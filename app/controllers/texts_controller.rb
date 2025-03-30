class TextsController < ApplicationController
  def index
  end

  def show
  end

  def edit  
  end

  def new
    
  end

  def analyze
    if request.post?
      @text = params[:text]
  
      if @text.present?
        analyzer = TextAnalyzerService.new(@text)
        @contains_threat = analyzer.contains_threat?
        @detected_words = analyzer.detected_words
        @highlighted_text = analyzer.highlighted_text
  
        respond_to do |format|
          format.html { render :result } # Render the 'result' view for HTML requests
          format.json { render json: { contains_threat: @contains_threat, detected_words: @detected_words } }
        end
      else
        flash[:alert] = "Please provide some text to analyze."
        redirect_to analyze_texts_path
      end
    else
      render :new # Render the form for GET requests
    end
  end
  
  
  
end





