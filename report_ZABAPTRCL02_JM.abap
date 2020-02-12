*&---------------------------------------------------------------------*
*& Report  ZABAPTRRP05_JM
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zabaptrrp05_jm.

DATA: go_pessoa_1       TYPE REF TO zabaptrcl02_jm,
      go_exception      TYPE REF TO zcx_abaptr01_jm, "Instanciando a classe de Exception
      gv_message        TYPE string,
      gv_cpf            TYPE zabaptrde09_jm,
      gv_cpf_formatado  TYPE char14,
      gv_nome           TYPE zabaptrde10_jm,
      gv_datanasc       TYPE zabaptrde11_jm,
      gv_nacionalidade  TYPE zabaptrde12_jm,
      gv_sexo           TYPE zabaptrde13_jm,
      gv_sexo_formatado TYPE char20.

****************************** Tela ******************************

PARAMETERS: p_oper          TYPE zabaptrde14_jm.

SELECTION-SCREEN SKIP.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.
PARAMETERS: p_cpf           TYPE zabaptrde09_jm DEFAULT '12345678910', "DEFAULT apenas para facilitar os testes
            p_nome          TYPE zabaptrde10_jm DEFAULT 'Pedro',
            p_datan         TYPE zabaptrde11_jm DEFAULT '20161111',
            p_nacio         TYPE zabaptrde12_jm DEFAULT 'Brasileiro' ,
            p_sexo          TYPE zabaptrde13_jm DEFAULT 'M'.
SELECTION-SCREEN END OF BLOCK b1.

****************************** Instanciando obj ******************************

TRY .

    CREATE OBJECT go_pessoa_1.

    CASE p_oper.
      WHEN 'C'.

        go_pessoa_1->create(
      EXPORTING
        iv_cpf           = p_cpf
        iv_nome          = p_nome
        iv_datanasc      = p_datan
        iv_nacionalidade = p_nacio
        iv_sexo          = p_sexo ).

        MESSAGE i001(00) WITH text-m01 DISPLAY LIKE 'S'. "Tipo i para pop-up, criando um tipo texto mNN com aparência de Sucesso

      WHEN 'M'.
        go_pessoa_1->buscar( p_cpf ).
        go_pessoa_1->modify(
      EXPORTING
        iv_nome          = p_nome
        iv_datanasc      = p_datan
        iv_nacionalidade = p_nacio
        iv_sexo          = p_sexo ).

        MESSAGE i001(00) WITH text-m02 DISPLAY LIKE 'S'.

      WHEN 'E'.
        go_pessoa_1->buscar( p_cpf ).
      WHEN 'V'.
        go_pessoa_1->buscar( p_cpf ). "Só funcionou porque ele é único e IMPORTING

****************************** GET's ******************************

        go_pessoa_1->get_cpf(
          IMPORTING
            ev_cpf = gv_cpf ).

        go_pessoa_1->get_nome(
          IMPORTING
            ev_nome = gv_nome ).

        go_pessoa_1->get_datanasc(
          IMPORTING
            ev_datanasc = gv_datanasc ).

        go_pessoa_1->get_nacionalidade(
          IMPORTING
            ev_nacionalidade = gv_nacionalidade ).

        go_pessoa_1->get_sexo(
          IMPORTING
            ev_sexo = gv_sexo ).

        gv_cpf_formatado  = go_pessoa_1->get_cpf_formatado( ). "Get mais simplificado com Return

        gv_sexo_formatado = go_pessoa_1->get_sexo_formatado( ).

****************************** WRITE ******************************

        WRITE: / 'cpf           ', gv_cpf_formatado.
        WRITE: / 'nome          ', gv_nome.
        WRITE: / 'datanasc      ', gv_datanasc.
        WRITE: / 'nacionalidade ', gv_nacionalidade.
        WRITE: / 'sexo          ', gv_sexo_formatado.

      WHEN OTHERS.
    ENDCASE.

  CATCH zcx_abaptr01_jm INTO go_exception. "Captura a Exception
    gv_message = go_exception->get_text( ).
    MESSAGE i001(00) WITH gv_message DISPLAY LIKE 'E'. "Mensagem a ser exibida como informativo LIKE erro

ENDTRY.