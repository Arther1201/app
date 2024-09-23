module ProsthesesHelper
    KANJI_TO_HIRAGANA = {
        "歯" => "は",
        "臼歯" => "きゅうし",
        "永久歯" => "えいきゅうし",
        "嚥下" => "えんげ",
        "親知らず" => "おやしらず",
        "下顎前突" => "かがくぜんとつ",
        "前装冠" => "せんそうかん",
        "義歯" => "きし",
        "金属床" => "きんぞくしょう",
        "仮歯" => "かりば",
        "顎関節症" => "かくかんせつしょう",
        "筋機能療法" => "きんきのうりょうほう",
        "矯正治療" => "きょうせいちりょう",
        "局部義歯" => "きょくぶぎし",
        "外科矯正" => "けかきゅうせい",
        "欠損" => "けっそん",
        "犬歯" => "けんし",
        "口角" => "こうかく",
        "口角炎" => "こうかくえん",
        "口腔外科" => "こうくうげか",
        "口臭" => "こうしゅう",
        "口唇ヘルペス" => "こうしんへるぺす",
        "口内炎" => "こうないえん",
        "硬質レジン" => "こうしつれじん",
        "根管治療(RCF)" => "こんかんちりょう",
        "根充" => "こ",
        "咬合" => "こうごう",
        "咬合性外傷" => "こうごうせいがいしょう",
        "咬合調整" => "こうごうちょうせい",
        "咬合平面" => "こうごうへいめん",
        "再石灰化" => "さいせっかいか",
        "歯肉整形術(GP)" => "しにくせいけいじゅつ",
        "支台歯" => "しだいし",
        "歯科衛生士" => "しかえいせいし",
        "歯科技工士" => "しかぎこうし",
        "歯科助手" => "しかじょしゅ",
        "歯牙" => "しが",
        "歯冠" => "しかん",
        "歯間" => "しかん",
        "歯間ブラシ" => "しかんぶらし",
        "歯頚部" => "しけいぶ",
        "歯垢" => "しこう",
        "歯根のう胞" => "しこんのうほう",
        "歯根吸収" => "しこんきゅうしゅう",
        "歯根膜" => "しこんまく",
        "歯根膜炎(pel)" => "しこんまくえん",
        "歯式" => "ししき",
        "歯質" => "ししつ",
        "歯周ポケット" => "ししゅうポケット",
        "歯周ポケット掻爬(PCUR)" => "ししゅうぽけっとそうは",
        "歯周病" => "ししゅうびょう",
        "歯髄" => "しずい",
        "歯髄炎(Pul)" => "しずいえん",
        "歯肉溝" => "しにくこう",
        "歯列" => "しれつ",
        "歯列弓" => "しれつきゅう",
        "主訴" => "しゅそ",
        "小臼歯" => "しょうきゅうし",
        "小児歯科" => "しょうにしか",
        "笑気鎮静法" => "しょうきちんせいほう",
        "上顎前突症" => "じょうがくぜんとつしょう",
        "審美歯科治療" => "しんびしかちりょう",
        "浸麻" => "しんま",
        "人工歯" => "しんこうし",
        "切歯" => "せっし",
        "前装冠(pd)" => "せんそうかん(pd)",
        "象牙質" => "そうげしつ",
        "叢生" => "そうせい",
        "総義歯" => "そうぎし",
        "咀嚼" => "そしゃく",
        "第3臼歯" => "たい３きゅうし",
        "大臼歯" => "たいきゅうし",
        "小臼歯" => "しょうきゅうし",
        "第4大臼歯" => "たい４きゅうし",
        "脱灰" => "たっかい",
        "知覚過敏" => "ちかくかびん",
        "智歯周囲炎(Perico)" => "ちししゅういえん(Perico)",
        "電鋳" => "てんちゅう",
        "天然歯" => "てんねんし",
        "挺出" => "ていしゅつ",
        "インプラント" => "いんぷらんと",
        "コア(Ag)" => "こあ(Ag)",
        "コア(ファイバー)" => "こあ(ファイバー)",
        "マウスピース" => "まうすぴーす",
        "スプリント" => "すぷりんと",
        "キーパー" => "きーぱー",
        "コーピング" => "こーぴんぐ",
        "ロケーター" => "ろけーたー",
        "コア(Au)" => "こあ(Au)",
        "セラミックIn" => "せらみっくIn",
        "ジルコニア" => "しるこにあ",
        "テセラ" => "てせら",
        "ノンクラスプデンチャー(K-プラス)" => "のんくらすぷでんちゃー(K-プラス)",
        "ノンクラスプデンチャー(エステショット)" => "のんくらすぷでんちゃー(エステショット)",
        "アマルガム" => "あまるがむ",
        "アンレー" => "あんれー",
        "インフォームドコンセント" => "いんふぉーむどこんせんと",
        "エアーアブレーション" => "えあーぶれーしょん",
        "エナメル質" => "えなめるしつ",
        "オールセラミッククラウン" => "おーるせらみっくくらうん",
        "カリエスリスク" => "かりえすりすく",
        "コーヌスクローネ" => "こーぬすくろーね",
        "コンポジットレジン(CR)" => "こんぽじっとれじん(CR)",
        "サージカルステント" => "さーじかるすてんと",
        "スケーラー" => "すけーらー",
        "スケーリング" => "すけーりんぐ",
        "スケーリングルートプレイニング(SRP)" => "すけーりんぐるーとぷれいにんぐ(SRP)",
        "スタディモデル" => "すたでぃもでる",
        "ステント(サージカルステント)" => "すてんと(サージカルステント)",
        "ストッピング(テンポラリーストッピング)" => "すとっぴんぐ(テンポラリーストッピング)",
        "スプリント" => "すぷりんと",
        "デンタルフロス" => "てんたるふろす",
        "トゥースブラッシングインストラクション（TBI）" => "とぅーすぷれっしんぐいんすとらくしょん（TBI）"
      } 
  
      def kanji_to_hiragana(name)
        # 既にひらがなやカタカナならそのまま返す
        if name =~ /\A[ァ-ンー]+\z/
          # カタカナの場合そのまま返す
          return name.tr("ァ-ン", "ぁ-ん")
        elsif name =~ /\A[ぁ-ん]+\z/
          # ひらがなもそのまま返す
          return name
        else
          # 漢字をひらがなに変換
          KANJI_TO_HIRAGANA[name] || name
        end
      end
end
