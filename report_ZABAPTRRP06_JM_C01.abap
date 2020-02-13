*&---------------------------------------------------------------------*
*&  Include           ZABAPTRRP06_JM_C01
*&---------------------------------------------------------------------*

CLASS lcl_report DEFINITION.
  PUBLIC SECTION.
*   Estrutora do Types ********************
    TYPES: BEGIN OF ty_s_pessoa,                   "BEGIN OF serve para criar uma estrutura local com campos específicos
              o_pessoa TYPE REF TO zabaptrcl02_jm, "Referenciamos o tipo objeto da classe Pessoa
           END OF ty_s_pessoa,                     "Finaliza o Types
           ty_t_pessoa TYPE TABLE OF ty_s_pessoa.  "Cria uma tabela do mesmo tipo da estrutura acima

*   Atributos da classe *******************
*   Tabela de objetos
    DATA: mt_pessoas TYPE ty_t_pessoa. "

*   Tabela global com dados obtidos dos objetos pós-processamento
    DATA: mt_dados_alv TYPE TABLE OF zabaptrs03_jm.

    DATA: mo_alv TYPE REF TO cl_salv_table.

    METHODS: "Declaração dos métodos
    selecao,
    processamento,
    exibicao.
ENDCLASS.                    "lcl_report DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_report IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_report IMPLEMENTATION.

  METHOD selecao.
    TYPES: BEGIN OF ty_s_selecao,      "BEGIN OF serve para criar uma estrutura local
              cpf TYPE zabaptrde09_jm, "Selecionando apenas o campo CPF
           END OF ty_s_selecao,        "Finaliza o Tpes

           ty_t_selecao TYPE TABLE OF ty_s_selecao. "Aproveitamos para declarar uma Tabela desta estrutura

*   Declara uma tabela que receberá os CPF's
    DATA: lt_selecao TYPE ty_t_selecao. "Tabela que traz os CPF's utilizando o SELECT

*   Estrutura que alimenta a tabela acima utilizando o LOOP com um objeto e o método buscar, trazendo apenas os CPF's da tabela05
    DATA: ls_selecao TYPE ty_s_selecao.

*   Estrutura que auxilia a processar o objeto buscado e alimenta a tabela de objetos mt_pessoas com todos os campos retornados do método buscar
    DATA: ls_pessoa TYPE ty_s_pessoa. "

    SELECT cpf
      FROM zabaptrt05_jm
      INTO TABLE lt_selecao.

    LOOP AT lt_selecao INTO ls_selecao.
      CLEAR ls_pessoa.
      CREATE OBJECT ls_pessoa-o_pessoa.
      ls_pessoa-o_pessoa->buscar( ls_selecao-cpf ).

*     Guardando os objetos pessoa em uma Estrutura de Tabela final
      APPEND ls_pessoa TO mt_pessoas.
    ENDLOOP.

  ENDMETHOD.                    "selecao
  METHOD processamento.

*   Estrutura que auxilia o processamento de objetos
    DATA: ls_pessoa TYPE ty_s_pessoa.

*   Estrutura que é populada por todos os atributos do objeto
    DATA: ls_dados_pessoa TYPE zabaptrs03_jm.

*   Loop nos objetos selecionados pelo METHOD SELECAO
    LOOP AT mt_pessoas INTO ls_pessoa.
      ls_pessoa-o_pessoa->get_pessoa(  "Referencia o objeto contido em uma linha da tabela mt_pessoas e dá GET
      IMPORTING
        es_pessoa = ls_dados_pessoa ). "ls_dados recebe o conteúdo do GET
      APPEND ls_dados_pessoa TO mt_dados_alv. "Appendamos o conteúdo da estrutura à tabela final
    ENDLOOP.

  ENDMETHOD.                    "processamento
  METHOD exibicao.
*   Criando o relatório ALV, declarando na classe a variáveis mo_alv referenciando cl_salv_table
*   Chama o método que constrói a saída ALV
    CALL METHOD cl_salv_table=>factory
      IMPORTING
        r_salv_table = mo_alv
      CHANGING
        t_table      = mt_dados_alv.

*   Mostra o ALV
    mo_alv->display( ). "Imprime na tela do relatório ALV

  ENDMETHOD.                    "exibicao
ENDCLASS.                    "lcl_report IMPLEMENTATION