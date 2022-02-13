# frozen_string_literal: true

RSpec.describe ConversationService do
  let(:service) { described_class.new(corrospondence_client) }
  let(:corrospondence_client) { instance_double(Corrospondence::Client) }

  describe '#start_conversation!(params)' do
    subject { service.start_conversation!(start_parameters) }

    let(:start_parameters) do
      { topic: 'Hello World', summary: 'These are my favorite talking points!' }
    end

    context 'when starting the conversation is succesful' do
      before { allow_client_to_create_conversation }

      it { is_expected.to be_a_kind_of(Conversation) }
    end

    context 'when creating the conversation is not succesful' do
      before { allow_client_to_not_create_conversation }

      it { expect { subject }.to raise_error(ConversationService::StartFailed) }
    end
  end

  describe '#find_conversation(id)' do
    subject { service.find_conversation('id') }

    context 'when the Conversation can be found' do
      before { allow_client_to_fetch_conversation }

      it { is_expected.to be_a_kind_of(Conversation) }
    end

    context 'when the Conversation cannot be found' do
      before { allow_client_to_not_fetch_conversation }

      it { is_expected.to be_nil }
    end
  end

  describe '#exists?(id)' do
    subject { service.exists?('id') }

    context 'when the Conversation exists' do
      before { allow_client_to_fetch_conversation }

      it { is_expected.to be true }
    end

    context 'when the Conversation does not exist' do
      before { allow_client_to_not_fetch_conversation }

      let(:id) { 'does-not-exist' }

      it { is_expected.to be false }
    end
  end

  def allow_client_to_create_conversation
    allow(corrospondence_client)
      .to receive(:create_conversation)
      .and_return(build(:corrospondence_response, :created_conversation))
  end

  def allow_client_to_not_create_conversation
    allow(corrospondence_client)
      .to receive(:create_conversation)
      .and_return(build(:corrospondence_response, :change_failed))
  end

  def allow_client_to_fetch_conversation
    allow(corrospondence_client)
      .to receive(:fetch_conversation)
      .and_return(build(:corrospondence_response, :found_conversation))
  end

  def allow_client_to_not_fetch_conversation
    allow(corrospondence_client)
      .to receive(:fetch_conversation)
      .and_return(build(:corrospondence_response, :not_found))
  end
end
