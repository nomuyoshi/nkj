# frozen_string_literal: true

RSpec.describe NKJ do
  it 'has a version number' do
    expect(Nkj::VERSION).not_to be nil
  end

  describe '.jisx0213?' do
    context 'Characters included in JIS X 0213' do
      let(:chars) do
        File.open('./spec/fixtures/jisx0213_chars.txt') { |f| f.readlines.map(&:chomp) }
      end

      it 'returns true' do
        aggregate_failures do
          chars.each do |char|
            expect(NKJ.jisx0213?(char)).to eq(true), "char = 「#{char}」"
          end
        end
      end
    end

    context 'Characters not included in JIS X 0213' do
      it 'returns false' do
        aggregate_failures do
          expect(NKJ.jisx0213?('ｱ')).to eq(false)
          expect(NKJ.jisx0213?('髙')).to eq(false)
          expect(NKJ.jisx0213?('𠮷')).to eq(false)
          expect(NKJ.jisx0213?('￡')).to eq(false)
          expect(NKJ.jisx0213?('😀')).to eq(false)
        end
      end
    end
  end

  describe '.level1?' do
    context 'first level kanji' do
      let(:chars) do
        File.open('./spec/fixtures/jisx0213_level1_chars.txt') { |f| f.readlines.map(&:chomp) }
      end

      it 'returns true' do
        aggregate_failures do
          chars.each do |char|
            expect(NKJ.level1?(char)).to eq(true), "char = 「#{char}」"
          end
        end
      end
    end

    context 'kanji outside of the first level' do
      it 'returns false' do
        aggregate_failures do
          expect(NKJ.level1?('丼')).to eq(false) # 第二水準
          expect(NKJ.level1?('﨑')).to eq(false) # 第三水準
          expect(NKJ.level1?('挻')).to eq(false) # 第四水準
          expect(NKJ.level1?('髙')).to eq(false) # JIS X 0213に存在しない
        end
      end
    end
  end

  describe '.level2?' do
    context 'second level kanji' do
      let(:chars) do
        File.open('./spec/fixtures/jisx0213_level2_chars.txt') { |f| f.readlines.map(&:chomp) }
      end

      it 'returns true' do
        aggregate_failures do
          chars.each do |char|
            expect(NKJ.level2?(char)).to eq(true), "char = 「#{char}」"
          end
        end
      end
    end

    context 'kanji outside of the second level' do
      it 'returns false' do
        aggregate_failures do
          expect(NKJ.level2?('腕')).to eq(false) # 第一水準
          expect(NKJ.level2?('﨑')).to eq(false) # 第三水準
          expect(NKJ.level2?('挻')).to eq(false) # 第四水準
          expect(NKJ.level2?('髙')).to eq(false) # JIS X 0213に存在しない
        end
      end
    end
  end

  describe '.level3?' do
    context 'third level kanji' do
      let(:chars) do
        File.open('./spec/fixtures/jisx0213_level3_chars.txt') { |f| f.readlines.map(&:chomp) }
      end

      it 'returns true' do
        aggregate_failures do
          chars.each do |char|
            expect(NKJ.level3?(char)).to eq(true), "char = 「#{char}」"
          end
        end
      end
    end

    context 'kanji outside of the third level' do
      it 'returns false' do
        aggregate_failures do
          expect(NKJ.level3?('腕')).to eq(false) # 第一水準
          expect(NKJ.level3?('丼')).to eq(false) # 第二水準
          expect(NKJ.level3?('挻')).to eq(false) # 第四水準
          expect(NKJ.level3?('髙')).to eq(false) # JIS X 0213に存在しない
        end
      end
    end
  end

  describe '.level4?' do
    context 'fourth level kanji' do
      let(:chars) do
        File.open('./spec/fixtures/jisx0213_level4_chars.txt') { |f| f.readlines.map(&:chomp) }
      end

      it 'returns true' do
        aggregate_failures do
          chars.each do |char|
            expect(NKJ.level4?(char)).to eq(true), "char = 「#{char}」"
          end
        end
      end
    end

    context 'kanji outside of the fourth level' do
      it 'returns false' do
        aggregate_failures do
          expect(NKJ.level4?('腕')).to eq(false) # 第一水準
          expect(NKJ.level4?('丼')).to eq(false) # 第二水準
          expect(NKJ.level1?('﨑')).to eq(false) # 第三水準
          expect(NKJ.level4?('髙')).to eq(false) # JIS X 0213に存在しない
        end
      end
    end
  end
end
