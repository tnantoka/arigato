require 'spec_helper'
require 'arigato'

module Arigato

  describe CLI do
    subject do
      CLI.new
    end

    describe '#version' do
      it 'displays version' do
        expect(capture(:stdout) { subject.invoke(:version) }.strip).to match(VERSION)
      end
    end

    describe '#themes' do
      it 'displays all themes' do
        themes = capture(:stdout) { subject.invoke(:themes) }.strip
        %w(default bootstrap).each do |theme|
          expect(themes).to match(theme)
        end
      end
    end

    describe '#json' do
      it 'displays specs as JSON' do
        json = capture(:stdout) { subject.invoke(:json) }.strip
        ['"name": "bundler",', '"name": "thor",'].each do |name|
          expect(json).to match(name)
        end
      end
    end

    describe '#yaml' do
      it 'displays specs as YAML' do
        yaml = capture(:stdout) { subject.invoke(:yaml) }.strip
        ['bundler:', 'thor:'].each do |name|
          expect(yaml).to match(name)
        end
      end
    end

    describe '#csv' do
      it 'displays specs as CSV' do
        yaml = capture(:stdout) { subject.invoke(:csv) }.strip
        ['bundler,', 'thor,'].each do |name|
          expect(yaml).to match(name)
        end
      end
    end

    describe '#generate' do
      before(:each) do
        FileUtils.rm_rf(CLI::HTML_DIR) if File.exists?(CLI::HTML_DIR)
      end

      context 'when theme is default' do
        before(:each) do
          subject.invoke(:generate, nil, file: 'Gemfile')
        end
        it 'makes thanks directory' do
          expect(File.exists?(CLI::HTML_DIR)).to be
        end
        it 'creates HTML file' do
          expect(File.exists?(CLI::HTML_FILE)).to be
        end
        it 'generate HTML with specs' do
          %w(thor bundler).each do |name|
            expect(File.read(CLI::HTML_FILE)).to match(name)
          end
        end
      end

      context 'when theme is bootstrap' do
        before(:each) do
          subject.invoke(:generate, ['bootstrap'], file: 'Gemfile')
        end
        it 'generate HTML with bootstrap' do
          expect(File.read(CLI::HTML_FILE)).to match('bootstrap')
        end
      end
    end
   
  end

  # https://github.com/wycats/thor/blob/master/spec/helper.rb
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end

end
