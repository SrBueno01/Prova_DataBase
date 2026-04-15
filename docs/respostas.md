## 1. SGBD

Foi escolhido um SGBD relacional (PostgreSQL) devido à necessidade de integridade e consistência dos dados.

As propriedades ACID garantem confiabilidade:

* Atomicidade: transações são completas ou revertidas
* Consistência: regras do banco são respeitadas
* Isolamento: transações não interferem entre si
* Durabilidade: dados persistem após commit

---

## Schemas

O uso de schemas melhora organização e segurança:

* academico → dados principais (alunos, disciplinas, turmas, matrículas)
* seguranca → controle de acesso e permissões

Isso segue boas práticas de ambientes corporativos.

---

## 2. Modelo Lógico (3FN)

Aluno(id_aluno, nome, email, ativo)
Professor(id_professor, nome, ativo)
Disciplina(id_disciplina, nome, ativo)
Turma(id_turma, id_disciplina, id_professor, semestre, ativo)
Matricula(id_matricula, id_aluno, id_turma, nota, ativo)

Este modelo está em 3FN pois:

* elimina redundância
* evita dependência parcial
* todas as colunas dependem da chave primária

---

## 5. Concorrência (ACID)

Em ambientes multiusuário, duas transações podem tentar alterar o mesmo registro simultaneamente.

O SGBD garante consistência através de:

* Isolamento: cada transação executa de forma independente
* Locks: bloqueiam registros durante atualização
* Controle de concorrência: evita sobrescrita e perda de dados

---

## Conclusão

Esse controle garante integridade mesmo em alto volume de acessos simultâneos em sistemas acadêmicos.

