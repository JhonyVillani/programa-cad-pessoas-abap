*&---------------------------------------------------------------------*
*&  Include           ZABAPTRRP06_JM_C01
*&---------------------------------------------------------------------*

CLASS lcl_report DEFINITION.
  PUBLIC SECTION.
*   Estrutora do Types ********************
    TYPES: BEGIN OF ty_s_pessoa, "BEGIN OF serve para criar uma estrutura local
              o_pessoa TYPE REF TO zabaptrcl02_jm,
           END OF ty_s_pessoa,
           ty_t_pessoa TYPE TABLE OF ty_s_pessoa.

*   Atributos da classe *******************
    DATA: mt_pessoas TYPE ty_t_pessoa.

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

    DATA: lt_selecao TYPE ty_t_selecao.

    SELECT cpf
      FROM zabaptrt05_jm
      INTO TABLE lt_selecao.

  ENDMETHOD.                    "selecao
  METHOD processamento.
  ENDMETHOD.                    "processamento
  METHOD exibicao.
  ENDMETHOD.                    "exibicao
ENDCLASS.                    "lcl_report IMPLEMENTATION