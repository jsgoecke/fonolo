require 'json'
require 'net/https'
require 'uri'

class Fonolo
  @@fonolo_api_version = "1.1"
  @@fonolo_uri = "https://json-rpc.live.fonolo.com/:443"
  
  #Initialize the Fonolo object and connect to the Fonolo service
  def initialize(username, password, auth_key)  
    @username = username
    @password = password
    
    @uri = URI.parse(@@fonolo_uri)
    @headers = { "Content-Type" => "application/json",
                 "X-Fonolo-Auth" => auth_key,
                 "X-Fonolo-Username" => username, 
                 "X-Fonolo-Password" => password }
    
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
  end

  #Method to invoke the Fonolo JSON-RPC
  def invoke_json_rpc(params)
    params.merge!({ :version => @@fonolo_api_version })
    resp, data = @http.post(@uri.path, params.to_json, @headers)
    return JSON.parse(data)
  end
  
  #Validates the given username and password against the fonolo database. 
  def check_member
    return invoke_json_rpc({ :method => "check_member", 
                             :params => [@username, @password] })
  end
  
  #Validates that the given number belongs to the username and password provided.
  def check_member_number(phonenumber)
    return invoke_json_rpc({ :method => "check_member_number", 
                             :params => [@username, @password, phonenumber] })
  end
  
  #Searches the fonolo database for the given company id or search string, and returns a standard  
  #company list.
  def company_search(search_string)
    return invoke_json_rpc({ :method => "company_search", 
                             :params => [search_string] })
  end
  
  #Lists all the companies in the fonolo database.  
  def company_list(max_per_page, page_value, start_date)
    return invoke_json_rpc({ :method => "company_list", 
                             :params => [max_per_page, page_value, start_date] })
  end
  
  #Returns all company details, including the full phone tree. 
  def company_details(company_id)
    return invoke_json_rpc({ :method => "company_details", 
                             :params => [company_id] })
  end
  
  #Initiates a deep‐dial to a specific location in a phone tree 
  def call_start(company_id, uri_or_number_to_dial)
    return invoke_json_rpc({ :method => "call_start", 
                             :params => [company_id, uri_or_number_to_dial] })
  end
  
  #Returns status details about an existing call, initiated from a call_start command.
  def call_status(session_id)
    return invoke_json_rpc({ :method => "call_status", 
                             :params => [session_id] })
  end
  
  #Cancels an existing call, initiated from a call_start command.
  def call_cancel(session_id)
    return invoke_json_rpc({ :method => "call_cancel", 
                             :params => [session_id] })
  end
end