*&---------------------------------------------------------------------*
*&  Include           ZABAPTRRP06_JM_C01
*&---------------------------------------------------------------------*

CLASS lcl_report DEFINITION.
  PUBLIC SECTION.
*   Estrutora do Types ********************
    TYPES: BEGIN OF ty_s_pessoa, "BEGIN OF serve para criar uma estrutura local
              o_pessoa TYPE REF TO zabaptrcl02_jm,
           END OF ty_s_pessoa,
           ty_t_pessoa TYPE TABLE OF ty_s_pessoa. "Cria uma tabela do mesmo tipo da estrutura acima

*   Atributos da classe *******************
    DATA: mt_pessoas TYPE ty_t_pessoa. "Tabela final de saídas

    METHODS:
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
    TYPES: BEGIN OF ty_s_selecao, "BEGIN OF serve para criar uma estrutura local
              cpf TYPE zabaptrde09_jm,
           END OF ty_s_selecao,
           ty_t_selecao TYPE TABLE OF ty_s_selecao.

*   Declara uma tabela que receberá os CPF's
    DATA: lt_selecao TYPE ty_t_selecao. "Tabela que traz os CPF's utilizando o SELECT

*   Estrutura que alimenta a tabela acima utilizando o LOOP com um objeto e o método buscar, trazendo apenas os CPF's da tabela 05
    DATA: ls_selecao TYPE ty_s_selecao.

*   Estrutura que retorna o objeto buscado e alimenta a tabela final mt_pessoas com todos os campos retornados do método buscar
    DATA: ls_pessoa TYPE ty_s_pessoa. "

    SELECT cpf
      FROM zabaptrt05_jm
      INTO TABLE lt_selecao.

    LOOP AT lt_selecao INTO ls_selecao.
      CLEAR ls_pessoa.
      CREATE OBJECT ls_pessoa-o_pessoa.
      ls_pessoa-o_pessoa->buscar( ls_selecao-cpf ).
      APPEND ls_pessoa TO mt_pessoas.
    ENDLOOP.

  ENDMETHOD.                    "selecao
  METHOD processamento.
  ENDMETHOD.                    "processamento
  METHOD exibicao.
  ENDMETHOD.                    "exibicao
ENDCLASS.                    "lcl_report IMPLEMENTATION