describe PHash do
  let(:hash_function) { OpenSSL::Digest::SHA256.new }
  let(:secret) { Base64.strict_decode64 'xwJkx4dOssrmbwaOAOksk8P/Fsx6H9HgU41qq6JlmR4=' }
  let(:seed)   { Base64.strict_decode64 'KfQG3n0PMLAC6UeevAb8w5DvCyhgCoGEOcXXEqoj7GU=' }
  let(:result) { Base64.strict_decode64 'qgdQSmZTCYhFn6LiijplKk6vwWEihxNgeZMBKeCEURI=' }
  let(:key_length) { nil }

  subject { described_class.new(*[hash_function, secret, seed, key_length].compact) }

  describe '#digest' do
    it { expect(subject.digest).to eq(result) }

    context 'with a shorter key length' do
      let(:key_length) { 16 }
      let(:result) { Base64.strict_decode64 'qgdQSmZTCYhFn6LiijplKg==' }

      it { expect(subject.digest).to eq(result) }
    end

    context 'with a longer key length' do
      let(:key_length) { 128 }
      let(:result) { Base64.strict_decode64 'qgdQSmZTCYhFn6LiijplKk6vwWEihxNgeZMBKeCEURJ5dig7iIwy1lguSO1nQv0TORlNipSbhaPj7MsqtAOM2kng0sZ99nwpTLHnF8QviBP8fRxirZE/K3EAUQs3Puhmi68M3rXU/B/qyeI7U7b5phv/wBzknH5RTrQFeBOs3Xg=' }

      it { expect(subject.digest).to eq(result) }
    end
  end

  describe '#hexdigest' do
    let(:result) { 'aa07504a66530988459fa2e28a3a652a4eafc1612287136079930129e0845112' }

    it { expect(subject.hexdigest).to eq(result) }
  end

  describe '#base64digest' do
    let(:result) { 'qgdQSmZTCYhFn6LiijplKk6vwWEihxNgeZMBKeCEURI=' }

    it { expect(subject.base64digest).to eq(result) }
  end
end
