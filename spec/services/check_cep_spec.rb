require 'rails_helper'

describe 'CEP API' do
  before do 
    body = {
            "cep": "17560-057",
            "logradouro": "Avenida Paulista",
            "complemento": "até 1598/1599",
            "bairro": "Centro",
            "localidade": "Vera Cruz",
            "uf": "SP",
            "ibge": "3556602",
            "gia": "7134",
            "ddd": "14",
            "siafi": "7235"
          }.to_json
    response = double("response", status: 200, body: body)
    allow(Faraday).to receive(:get).and_return(response)
  end
  
  it 'GET viacep.com.br/ws/CEPINFORMADO/json/' do

    cep = '17560057'

    response = Faraday.get("https://viacep.com.br/ws/#{cep}/json/")

    expect(response.status).to eq 200
    json_response = JSON.parse(response.body)
    expect(json_response['cep']).to eq('17560-057')
    expect(json_response['logradouro']).to eq('Avenida Paulista')
    expect(json_response['complemento']).to eq('até 1598/1599')
    expect(json_response['bairro']).to eq('Centro')
    expect(json_response['localidade']).to eq('Vera Cruz')
    expect(json_response['uf']).to eq('SP')
    expect(json_response['ibge']).to eq('3556602')
    expect(json_response['gia']).to eq('7134')
    expect(json_response['ddd']).to eq('14')
    expect(json_response['siafi']).to eq('7235')
  end

  it '#check_api' do
    cep = '17560057'
    result = CheckCep.check_api(cep)
    expect(result).to eq 'SP'
  end

end