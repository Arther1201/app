class ProsthesesController < ApplicationController
  def index
    if params[:group]
      @prostheses = Prosthesis.where(group: params[:group]).order(:name)
    else
      @prostheses = Prosthesis.order(:name)
    end
  end

    def show
        @prosthesis = Prosthesis.find(params[:id])
        if @prosthesis
            render json: { name: @prosthesis.name, description: @prosthesis.description }
        else
            render json: { error: '補綴情報が見つかりませんでした。' }, status: 404
        end
    end

    include ProsthesesHelper 

    def kanji_to_hiragana(name)
      # ひらがなに変換する処理
      KANJI_TO_HIRAGANA[name] || name
    end

    def list
      if params[:group] && params[:letter]
        # グループに基づいてフィルタリング
        @prostheses = Prosthesis.where(group: params[:group])
    
        # letterが指定されている場合、その文字でさらに絞り込み
        @prostheses = @prostheses.select do |prosthesis|

          if params[:letter] =~ /[A-Z]/
            prosthesis.name.start_with?(params[:letter])
          else
          # 名前をひらがなに変換
          hiragana_name = kanji_to_hiragana(prosthesis.name)
            
          # hiragana_nameの最初の文字を取得してフィルタリング
          case params[:letter]
          when 'あ'
            hiragana_name.start_with?('あ')
          when 'い'
            hiragana_name.start_with?('い')
          when 'う'
            hiragana_name.start_with?('う')
          when 'え'
            hiragana_name.start_with?('え')
          when 'お'
            hiragana_name.start_with?('お')
          when 'か'
            hiragana_name.start_with?('か')
          when 'き'
            hiragana_name.start_with?('き')
          when 'く'
            hiragana_name.start_with?('く')
          when 'け'
            hiragana_name.start_with?('け')
          when 'こ'
            hiragana_name.start_with?('こ')
          when 'さ'
            hiragana_name.start_with?('さ')
          when 'し'
            hiragana_name.start_with?('し')
          when 'す'
            hiragana_name.start_with?('す')
          when 'せ'
            hiragana_name.start_with?('せ')
          when 'そ'
            hiragana_name.start_with?('そ')
          when 'た'
            hiragana_name.start_with?('た')
          when 'ち'
            hiragana_name.start_with?('ち')
          when 'つ'
            hiragana_name.start_with?('つ')
          when 'て'
            hiragana_name.start_with?('て')
          when 'と'
            hiragana_name.start_with?('と')
          when 'な'
            hiragana_name.start_with?('な')
          when 'に'
            hiragana_name.start_with?('に')
          when 'ぬ'
            hiragana_name.start_with?('ぬ')
          when 'ね'
            hiragana_name.start_with?('ね')
          when 'の'
            hiragana_name.start_with?('の')
          when 'は'
            hiragana_name.start_with?('は')
          when 'ひ'
            hiragana_name.start_with?('ひ')
          when 'ふ'
            hiragana_name.start_with?('ふ')
          when 'へ'
            hiragana_name.start_with?('へ')
          when 'ほ'
            hiragana_name.start_with?('ほ')
          when 'ま'
            hiragana_name.start_with?('ま')
          when 'み'
            hiragana_name.start_with?('み')
          when 'む'
            hiragana_name.start_with?('む')
          when 'め'
            hiragana_name.start_with?('め')
          when 'も'
            hiragana_name.start_with?('も')
          when 'や'
            hiragana_name.start_with?('や')
          when 'ゆ'
            hiragana_name.start_with?('ゆ')
          when 'よ'
            hiragana_name.start_with?('よ')
          when 'ら'
            hiragana_name.start_with?('ら')
          when 'り'
            hiragana_name.start_with?('り')
          when 'る'
            hiragana_name.start_with?('る')
          when 'れ'
            hiragana_name.start_with?('れ')
          when 'ろ'
            hiragana_name.start_with?('ろ')
          when 'わ'
            hiragana_name.start_with?('わ')
          when 'を'
            hiragana_name.start_with?('を')
          when 'ん'
            hiragana_name.start_with?('ん')
          when 'A'
            hiragana_name.start_with?('A')
          else
            false
          end
        end
        end
      elsif params[:group]
        # グループだけでフィルタリング
        @prostheses = Prosthesis.where(group: params[:group])
      else
        # 全てのデータを取得
        @prostheses = Prosthesis.all
      end
    
      # 詳細表示のための処理
      if params[:id] && request.xhr?
        prosthesis = Prosthesis.find(params[:id])
        render json: { name: prosthesis.name, description: prosthesis.description }
      else 
        respond_to do |format|
          format.html # 通常のHTMLリクエスト
          format.json { render json: @prostheses }
        end
      end
    end
end
