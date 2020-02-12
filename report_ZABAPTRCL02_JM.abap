*&---------------------------------------------------------------------*
*& Report  ZABAPTRRP05_JM
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zabaptrrp05_jm.

DATA: go_pessoa_1 TYPE REF TO zabaptrcl02_jm,
gv_cpf            TYPE zabaptrde09_jm,
gv_cpf_formatado  TYPE char14,
gv_nome           TYPE zabaptrde10_jm,
gv_datanasc       TYPE zabaptrde11_jm,
gv_nacionalidade  TYPE zabaptrde12_jm,
gv_sexo           TYPE zabaptrde13_jm,
gv_sexo_formatado TYPE char20.

CREATE OBJECT go_pessoa_1.  

****************************** SET's ******************************

go_pessoa_1->set_cpf(
  EXPORTING
    iv_cpf = '12345678911' ).

go_pessoa_1->set_nome(
  EXPORTING
    iv_nome = 'Pedro' ).

go_pessoa_1->set_datanasc(
  EXPORTING
    iv_datanasc = '20161111' ).

go_pessoa_1->set_nacionalidade(
  EXPORTING
    iv_nacionalidade = 'Brasileira' ).

go_pessoa_1->set_sexo(
  EXPORTING
    iv_sexo = 'M' ).

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

go_pessoa_1->save( ).