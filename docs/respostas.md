## 1. SGBD

Escolhi utilizar um SGBD relacional como PostgreSQL, pois ele garante as propriedades ACID:

* Atomicidade: garante que uma transação seja concluída totalmente ou não aconteça
* Consistência: mantém os dados válidos conforme as regras do banco
* Isolamento: impede que transações interfiram umas nas outras
* Durabilidade: garante que os dados não sejam perdidos após serem salvos

Isso é essencial em um sistema acadêmico, pois envolve notas, matrículas e dados sensíveis.

---

## Schemas

O uso de schemas permite organizar melhor o banco de dados.

Separando em:

* academico → dados principais do sistema
* seguranca → controle de acesso

Isso facilita manutenção, segurança e escalabilidade.

---

## 2. Modelo Lógico

Aluno(id_aluno, nome, email, ativo)

Professor(id_professor, nome)

Disciplina(id_disciplina, nome)

Matricula(id_matricula, id_aluno, id_disciplina, nota, ciclo, ativo)

---

## 5. Concorrência

Quando dois usuários tentam alterar a mesma informação ao mesmo tempo, o banco de dados utiliza controle de transações.

O isolamento garante que cada transação ocorra separadamente.

Os locks (bloqueios) impedem alterações simultâneas no mesmo dado, evitando inconsistência e corrupção das informações.
