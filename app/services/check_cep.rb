
class CheckCep
  def self.check_api(params)
    @params = params
    response = Faraday.get("https://viacep.com.br/ws/#{@params}/json/")
    if response.status == 200
      response_body = JSON.parse(response.body)
      @state = response_body['uf']
    else
      raise ArgumentError, 'A API não está disponível'
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
    'SP'
  end
end