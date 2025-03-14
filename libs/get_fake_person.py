from faker import Faker

faker = Faker('pt_BR');

# Remove pontos de uma string de nome
def limpar_ponto_nome(nome):
    # Remove apenas o ponto
    nome_limpo = nome.replace('.', '')
    return nome_limpo

# Remove pontos e traços de uma string de CPF
def limpar_cpf(cpf):
    # Remove pontos e traços
    cpf_limpo = cpf.replace('.', '').replace('-', '')
    return cpf_limpo


def get_fake_person():
    person = {
        "name": limpar_ponto_nome(faker.name()),
        "email": faker.email(),
        "cpf": limpar_cpf(faker.cpf()),
    }
    return person