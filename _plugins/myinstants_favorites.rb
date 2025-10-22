# # --- Step 2b: handle login and return cookie header --------------------------
#
# def fetch_with_redirect(uri, headers = {}, form_data = nil)
  # http = Net::HTTP.new(uri.host, uri.port)
  # http.use_ssl = true
  # req = form_data ? Net::HTTP::Post.new(uri) : Net::HTTP::Get.new(uri)
  # headers.each { |k, v| req[k] = v }
  # req.set_form_data(form_data) if form_data
  # res = http.request(req)
  # # follow up to one redirect manually
  # if res.is_a?(Net::HTTPRedirection) && res["location"]
    # new_uri = URI.join(uri, res["location"])
    # return fetch_with_redirect(new_uri, headers)
  # end
  # res
# end
#
# # --- Step 3: login -----------------------------------------------------------
#
# base_headers = {
  # "User-Agent" =>
    # "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 " \
    # "(KHTML, like Gecko) Chrome/121.0 Safari/537.36",
  # "Content-Type" => "application/x-www-form-urlencoded",
  # "Referer" => login_url.to_s
# }
#
# login_response = fetch_with_redirect(
  # login_url,
  # base_headers.merge("Cookie" => cookies),
  # {
    # "csrfmiddlewaretoken" => csrf_token,
    # "login" => email,
    # "password" => password
  # }
# )
#
# cookie_header = [cookies, login_response["set-cookie"]].compact.join("; ")
#
# # --- Step 4: fetch favorites -------------------------------------------------
#
# fav_headers = base_headers.merge("Cookie" => cookie_header)
# fav_response = fetch_with_redirect(favorites_url, fav_headers)
#
# unless fav_response.is_a?(Net::HTTPSuccess)
  # Jekyll.logger.error "MyInstants:", "Favorites request failed (#{fav_response.code})"
  # return
# end
#
# html = fav_response.body
# if html.nil? || html.strip.empty?
  # Jekyll.logger.error "MyInstants:", "Favorites page returned empty body"
  # return
# end
#
# debug_path = File.join(site.source, "_data", "myinstants_favorites_debug.html")
# File.write(debug_path, html)
# Jekyll.logger.info "MyInstants:", "Favorites HTML saved to #{debug_path}"
# doc = Nokogiri::HTML(html)
