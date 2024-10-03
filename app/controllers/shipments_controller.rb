class ShipmentsController < ApplicationController
    def index
        @shipments = [
          { name: 'クロネコヤマト', homepage: 'https://auth.kms.kuronekoyamato.co.jp/auth/login?forwardUrl=https%3A%2F%2Fmember.kms.kuronekoyamato.co.jp%2Fmember%2F', id: 'kirakirasmile1624', password: 'kiradc1624' },
          { name: '杏友会', phone: '03-6821-3398', hospital_id: '54212' },
          { name: '株式会社E-joint', address: '〒358-1116 埼玉県所沢市東町10-16 廣澤ビル3F' },
          { name: '株式会社GIKO', phone: '03-6456-1535', address: '〒 816-0811  東京都世田谷区桜上水2-8-10' }
        ]
    end
end
