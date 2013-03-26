# coding: UTF-8

require 'spec_helper'
require 'arigato'

module Arigato

  describe View do

    context 'when @layout is true' do
      subject do
        View.new('default') 
      end
      describe '#render' do
        it 'returns themed HTML with layout' do
          expect(subject.render).to match('<!doctype html>')    
        end
        it 'contains specs name' do
          %w(thor bundler).each do |name|
            expect(subject.render).to match(name)    
          end
        end
        it 'contains specs homepage' do
          %w(http://gembundler.com http://whatisthor.com/).each do |homepage|
            expect(subject.render).to match(homepage)    
          end
        end
        it 'contains specs author' do
          %w(André Arko Yehuda Katz).each do |author|
            expect(subject.render).to match(author)    
          end
        end
      end
    end

    context 'when @layout is false' do
      subject do
        View.new('bootstrap', 'Gemfile', false) 
      end
      describe '#render' do
        it 'returns themed HTML without layout' do
          expect(subject.render).to_not match('<!doctype html>')    
        end
        it 'contains specs name' do
          %w(thor bundler).each do |name|
            expect(subject.render).to match(name)    
          end
        end
        it 'contains specs homepage' do
          %w(http://gembundler.com http://whatisthor.com/).each do |homepage|
            expect(subject.render).to match(homepage)    
          end
        end
        it 'contains specs author' do
          %w(André Arko Yehuda Katz).each do |author|
            expect(subject.render).to match(author)    
          end
        end
      end
    end

  end

end

