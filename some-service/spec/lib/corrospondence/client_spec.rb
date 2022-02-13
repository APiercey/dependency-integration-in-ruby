# frozen_string_literal: true

require_relative '../../helpers/corrospondence_oauth_helper'

RSpec.describe Corrospondence::Client, :integrated do
  let(:client) { described_class.new(app_tree.corrospondence_conn) }
  let(:app_tree) { AppTree.new }

  let(:create_forum_attrs) do
    {
      title: 'My Title',
      description: 'Some Description',
      category: 'finance'
    }
  end

  let(:create_conversation_attrs) do
    {
      topic: 'My Topic',
      summary: 'Some Description',
      content_owner_id: 'another-uuid-that-defines-a-relationship'
    }
  end

  before do
    app_tree.corrospondence_conn.request :authorization, 'Bearer', CorrospondenceOauthHelper.create_access_token!
  end

  describe '#create_forum' do
    subject { client.create_forum(create_forum_attrs) }

    it { is_expected.to be_a(Corrospondence::Response) }
    it { is_expected.to be_valid }

    context 'with a successful response' do
      it 'provides a 201 status' do
        expect(subject.status).to be(201)
      end

      it 'exposes ForumData' do
        expect(subject.data).to be_a(Corrospondence::ForumData)
      end

      it 'uses provided values' do
        expect(subject.data.title).to eq(create_forum_attrs[:title])
        expect(subject.data.description).to eq(create_forum_attrs[:description])
      end
    end

    context 'with a failed response' do
      let(:create_forum_attrs) do
        { title: 'fails' }
      end

      it 'exposes ErrorData' do
        expect(subject.data).to be_a(Corrospondence::ErrorData)
      end

      it 'provides error messages' do
        expect(subject.data.response_errors).not_to be_empty
      end
    end
  end

  describe '#fetch_forum' do
    subject { client.fetch_forum(id) }

    let(:id) { client.create_forum(create_forum_attrs).data.id }

    it { is_expected.to be_a(Corrospondence::Response) }
    it { is_expected.to be_valid }

    context 'when successful' do
      it 'provides a 200 status' do
        expect(subject.status).to be(200)
      end

      it 'exposes ForumData' do
        expect(subject.data).to be_a(Corrospondence::ForumData)
      end

      it 'finds the correct forum' do
        expect(subject.data.id).to eql(id)
      end
    end

    context 'when unsuccessful' do
      let(:id) { 'does-not-exist' }

      it 'provides a 404 status' do
        expect(subject.status).to be(404)
      end

      it 'exposes ErrorData' do
        expect(subject.data).to be_a(Corrospondence::ErrorData)
      end
    end
  end

  describe '#create_conversation' do
    subject { client.create_conversation(forum_id, create_conversation_attrs) }

    let(:forum_id) { client.create_forum(create_forum_attrs).data.id }

    it { is_expected.to be_a(Corrospondence::Response) }
    it { is_expected.to be_valid }

    context 'with a successful response' do
      it 'provides a 201 status' do
        expect(subject.status).to be(201)
      end

      it 'exposes ConversationData' do
        expect(subject.data).to be_a(Corrospondence::ConversationData)
      end

      it 'uses provided values' do
        expect(subject.data.topic).to eq(create_conversation_attrs[:topic])
        expect(subject.data.summary).to eq(create_conversation_attrs[:summary])
      end
    end

    context 'with parameters are missing' do
      let(:create_conversation_attrs) do
        { topic: 'fails' }
      end

      it 'provides a 422 status' do
        expect(subject.status).to be(422)
      end

      it 'exposes ErrorData' do
        expect(subject.data).to be_a(Corrospondence::ErrorData)
      end

      it 'provides error messages' do
        expect(subject.data.response_errors).not_to be_empty
      end
    end
  end

  describe '#fetch_conversation' do
    subject { client.fetch_conversation(forum_id, id) }

    let(:forum_id) { client.create_forum(create_forum_attrs).data.id }
    let(:id) { client.create_conversation(forum_id, create_conversation_attrs).data.id }

    it { is_expected.to be_a(Corrospondence::Response) }
    it { is_expected.to be_valid }

    context 'when successful' do
      it 'provides a 200 status' do
        expect(subject.status).to be(200)
      end

      it 'exposes ConversationData' do
        expect(subject.data).to be_a(Corrospondence::ConversationData)
      end

      it 'finds the correct Conversation' do
        expect(subject.data.id).to eql(id)
      end
    end

    context 'when unsuccessful' do
      let(:id) { 'does-not-exist' }

      it 'provides a 404 status' do
        expect(subject.status).to be(404)
      end

      it 'exposes ErrorData' do
        expect(subject.data).to be_a(Corrospondence::ErrorData)
      end

      it 'provides error messages' do
        expect(subject.data.response_errors).not_to be_empty
      end
    end
  end
end
