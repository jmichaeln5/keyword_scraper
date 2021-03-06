class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  ### Error page, redirected to when Server Error
  def error
      @user = current_user
      @sites = Site.where(user_id: @user).order("created_at ASC")
  end

  # GET /sites
  # GET /sites.json
  def index

    @user = current_user
    @sites = Site.where(user_id: @user).order("created_at DESC")

    ### Necessary to require for Heroku for view or WILL error out
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'

    begin
      @sites.each do |site|

        @site_link = site.link.to_s

        if @site_link.exclude? "http"
            redirect_to error_path and return
        end

        @site_open = Nokogiri::HTML(open(@site_link))
        @official_title = @site_open.at_css("title").text

        ### Rescues from OpenURI HTTPError(s)
        rescue OpenURI::HTTPError
          ###(Specifically wrote rescue block from begin for 900 Server error when trying to scrape LinkedIn Profiles)
        redirect_to error_path and return
      end
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    ### Necessary to require for Heroku for view or WILL error out
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'

    @user = current_user
    @site = Site.find(params[:id])
    @site_link = @site.link.to_s

    if @site_link.exclude? "http"
        redirect_to error_path and return
    end

    begin
      # @site_link = @site.link.to_s
      @site_element = @site.element

      @html_doc = Nokogiri::HTML(open(@site_link))
      @official_title = @html_doc.at_css("title").text
      @element_results = @html_doc.search("#{@site.element}")
      ### Rescues from OpenURI HTTPError(s)
      rescue OpenURI::HTTPError

      redirect_to error_path and return
    end
  end

  # GET /sites/new
  def new
    @user = current_user
    @site = @user.sites.build
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = current_user.sites.build(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:link, :title, :element, :user_id)
    end
end
