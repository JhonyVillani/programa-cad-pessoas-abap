class ZABAPTRCL02_JM definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IV_CPF type ZABAPTRDE09_JM
      !IV_NOME type ZABAPTRDE10_JM
      !IV_DATANASC type ZABAPTRDE11_JM
      !IV_NACIONALIDADE type ZABAPTRDE12_JM
      !IV_SEXO type ZABAPTRDE13_JM
    raising
      ZCX_ABAPTR01_JM .
  methods GET_CPF
    exporting
      !EV_CPF type ZABAPTRDE09_JM .
  methods GET_NOME
    exporting
      !EV_NOME type ZABAPTRDE10_JM .
  methods GET_DATANASC
    exporting
      !EV_DATANASC type ZABAPTRDE11_JM .
  methods GET_NACIONALIDADE
    exporting
      !EV_NACIONALIDADE type ZABAPTRDE12_JM .
  methods GET_SEXO
    exporting
      !EV_SEXO type ZABAPTRDE13_JM .
  methods SET_CPF
    importing
      !IV_CPF type ZABAPTRDE09_JM
    raising
      ZCX_ABAPTR01_JM .
  methods SET_NOME
    importing
      !IV_NOME type ZABAPTRDE10_JM .
  methods SET_DATANASC
    importing
      !IV_DATANASC type ZABAPTRDE11_JM .
  methods SET_NACIONALIDADE
    importing
      !IV_NACIONALIDADE type ZABAPTRDE12_JM .
  methods SET_SEXO
    importing
      !IV_SEXO type ZABAPTRDE13_JM .
  methods GET_CPF_FORMATADO
    returning
      value(RV_CPF_FORMATADO) type CHAR14 .
  methods GET_SEXO_FORMATADO
    returning
      value(RV_SEXO_FORMATADO) type CHAR20 .
  methods SAVE
    raising
      ZCX_ABAPTR01_JM .
protected section.
private section.

  data MV_CPF type ZABAPTRDE09_JM .
  data MV_NOME type ZABAPTRDE10_JM .
  data MV_DATANASC type ZABAPTRDE11_JM .
  data MV_NACIONALIDADE type ZABAPTRDE12_JM .
  data MV_SEXO type ZABAPTRDE13_JM .

  methods VALIDATE
    returning
      value(RV_SUBRC) type SY-SUBRC
    raising
      ZCX_ABAPTR01_JM .
ENDCLASS.



CLASS ZABAPTRCL02_JM IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_CPF                         TYPE        ZABAPTRDE09_JM
* | [--->] IV_NOME                        TYPE        ZABAPTRDE10_JM
* | [--->] IV_DATANASC                    TYPE        ZABAPTRDE11_JM
* | [--->] IV_NACIONALIDADE               TYPE        ZABAPTRDE12_JM
* | [--->] IV_SEXO                        TYPE        ZABAPTRDE13_JM
* | [!CX!] ZCX_ABAPTR01_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD constructor.

set_cpf(
  EXPORTING
    iv_cpf = iv_cpf ).

set_nome(
  EXPORTING
    iv_nome = iv_nome ).

set_datanasc(
  EXPORTING
    iv_datanasc = iv_datanasc ).

set_nacionalidade(
  EXPORTING
    iv_nacionalidade = iv_nacionalidade ).

set_sexo(
  EXPORTING
    iv_sexo = iv_sexo ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->GET_CPF
* +-------------------------------------------------------------------------------------------------+
* | [<---] EV_CPF                         TYPE        ZABAPTRDE09_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD get_cpf.
  ev_cpf = mv_cpf.
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->GET_CPF_FORMATADO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_CPF_FORMATADO               TYPE        CHAR14
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD get_cpf_formatado.
  CONCATENATE mv_cpf(3)   "Pega os 3 primeiros
          '.' mv_cpf+3(3) "Pular 3 caracteres, adiciona um ponto e pega os 3 próximos
          '.' mv_cpf+6(3) "Pular 6, adicionar um ponto e pegar mais 3 caracteres
          '-' mv_cpf+9(2) INTO rv_cpf_formatado. "Imprime os 2 restantes
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->GET_DATANASC
* +-------------------------------------------------------------------------------------------------+
* | [<---] EV_DATANASC                    TYPE        ZABAPTRDE11_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD GET_DATANASC.
  ev_datanasc = mv_datanasc.
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->GET_NACIONALIDADE
* +-------------------------------------------------------------------------------------------------+
* | [<---] EV_NACIONALIDADE               TYPE        ZABAPTRDE12_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD get_nacionalidade.
  ev_nacionalidade = mv_nacionalidade.
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->GET_NOME
* +-------------------------------------------------------------------------------------------------+
* | [<---] EV_NOME                        TYPE        ZABAPTRDE10_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD get_nome.
  ev_nome = mv_nome.
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->GET_SEXO
* +-------------------------------------------------------------------------------------------------+
* | [<---] EV_SEXO                        TYPE        ZABAPTRDE13_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD get_sexo.
  ev_sexo = mv_sexo.
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->GET_SEXO_FORMATADO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_SEXO_FORMATADO              TYPE        CHAR20
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD get_sexo_formatado.

  DATA: lv_domvalue TYPE dd07v-domvalue_l,  "Criando variável do tipo correto
        lv_ddtext   TYPE dd07v-ddtext.      "Mesma coisa

  lv_domvalue = mv_sexo. "Recebe o atributo da classe

  CALL FUNCTION 'DOMAIN_VALUE_GET'
    EXPORTING
      i_domname  = 'ZABAPTRD13_JM' "DOMÍNIO da variável e NÃO ELEMENTO DE DADOS!
      i_domvalue = lv_domvalue
    IMPORTING
      e_ddtext   = lv_ddtext
    EXCEPTIONS
      not_exist  = 1
      OTHERS     = 2.

    rv_sexo_formatado = lv_ddtext.


ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->SAVE
* +-------------------------------------------------------------------------------------------------+
* | [!CX!] ZCX_ABAPTR01_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD save.
  DATA: ls_zabaptrt05_jm TYPE zabaptrt05_jm,
        lv_subrc         TYPE sysubrc. "Validaremos se o campo CPF está em branco

  validate( ). "Recebe a validação

  ls_zabaptrt05_jm-cpf           =  mv_cpf.
  ls_zabaptrt05_jm-nome          =  mv_nome.
  ls_zabaptrt05_jm-datanasc      =  mv_datanasc.
  ls_zabaptrt05_jm-nacionalidade =  mv_nacionalidade.
  ls_zabaptrt05_jm-sexo          =  mv_sexo.
  MODIFY zabaptrt05_jm FROM ls_zabaptrt05_jm.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->SET_CPF
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_CPF                         TYPE        ZABAPTRDE09_JM
* | [!CX!] ZCX_ABAPTR01_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD set_cpf.
  DATA lv_len TYPE i.

  lv_len = strlen( iv_cpf ).

  IF lv_len = 11. "Conta se o CPF contém 11 caracteres

    IF iv_cpf+9(2) = '10'. "Verifica se o dígito é igual a 10
      mv_cpf = iv_cpf.
    ELSE.
      RAISE EXCEPTION TYPE zcx_abaptr01_jm
        EXPORTING
          textid = zcx_abaptr01_jm=>cpf_dig_10.
    ENDIF.

  ELSE.
    RAISE EXCEPTION TYPE zcx_abaptr01_jm
      EXPORTING
        textid = zcx_abaptr01_jm=>cpf_invalido.

    mv_cpf = iv_cpf.
  ENDIF.
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->SET_DATANASC
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_DATANASC                    TYPE        ZABAPTRDE11_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD SET_DATANASC.
  mv_datanasc = iv_datanasc.
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->SET_NACIONALIDADE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_NACIONALIDADE               TYPE        ZABAPTRDE12_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD set_nacionalidade.
  mv_nacionalidade = iv_nacionalidade.
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->SET_NOME
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_NOME                        TYPE        ZABAPTRDE10_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD set_nome.
  mv_nome = iv_nome.
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL02_JM->SET_SEXO
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_SEXO                        TYPE        ZABAPTRDE13_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD set_sexo.
  mv_sexo = iv_sexo.
ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZABAPTRCL02_JM->VALIDATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_SUBRC                       TYPE        SY-SUBRC
* | [!CX!] ZCX_ABAPTR01_JM
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD validate.
  IF mv_cpf IS INITIAL.
    RAISE EXCEPTION TYPE zcx_abaptr01_jm
      EXPORTING
        textid = zcx_abaptr01_jm=>cpf_branco.
  ENDIF.
ENDMETHOD.
ENDCLASS.