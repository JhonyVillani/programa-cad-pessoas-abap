*&---------------------------------------------------------------------*
*& Report  ZABAPTRRP06_JM
*&---------------------------------------------------------------------*

REPORT zabaptrrp06_jm.

INCLUDE zabaptrrp06_jm_c01. "Include para primeira classe do programa

DATA: go_report TYPE REF TO lcl_report. "Classe local

START-OF-SELECTION.
  CREATE OBJECT go_report.

  go_report->selecao( ).

  go_report->processamento( ).

  go_report->exibicao( ).