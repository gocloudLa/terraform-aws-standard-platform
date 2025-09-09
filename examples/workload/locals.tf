locals {

  custom_error_response = [
    {
      "error_caching_min_ttl" : 0,
      "error_code" : "400",
      "response_code" : "200",
      "response_page_path" : "/index.html"
    },
    {
      "error_caching_min_ttl" : 0,
      "error_code" : "403",
      "response_code" : "200",
      "response_page_path" : "/index.html"
    },
    {
      "error_caching_min_ttl" : 0,
      "error_code" : "404",
      "response_code" : "200",
      "response_page_path" : "/index.html"
    }
  ]

}
