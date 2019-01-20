class OwnershipsController < ApplicationController
  
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])
    
    unless @item.persisted?
    #@itemが保存されていない場合、先に@itemを保存する
    results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
    
    @item = Item.new(read(results.first))
    @item.save
    end
    
    #Want　関係として保存
    if params[:type] == 'Want'
      current_user.want(@item)
      flash[:success] = '商品をWantしました。'
    end
  
    if params[:type] == 'Have'
      current_user.have(@item)
      flash[:success] = '商品をHaveしました。'
    end
    
    redirect_back(fallback_location: root_path)
  end



  def destroy
    @item = Item.find(params[:item_id])
    
    if params[:type] == 'Want'
      current_user.unwhat(@item)
      flash[:success] = '商品のWantを解除しました。'
    end
    
    
    if params[:type] == 'Have'
      current_user.unhave(@item)
      flash[:success] = "商品のHaveを解除しました。"
    end
    redirect_back(fallback_location: root_path)
    
  end
  
  
  
end
