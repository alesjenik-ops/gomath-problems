String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD23C0T02';
Integer YEAR = 2023;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M7B 2023 - uloha 4',
  new List<String>{'Cisla v ovalech musi byt kladna a vsechny vypocty provedene ve smeru sipek musi byt spravne. Vzor: z cisla $3$ vznikne po operaci $\\cdot 2$ cislo $6$ a po operaci $+3$ cislo $9$.','4.1 Urcete cislo, ktere bude v diagramu misto otazniku (viz obrazek vlevo).','4.2 Urcete cislo, ktere bude v diagramu misto otazniku (viz obrazek vpravo).'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 260" font-family="sans-serif"> <text x="30" y="30" font-size="14" font-weight="bold">4.1</text> <ellipse cx="90" cy="80" rx="34" ry="24" fill="none" stroke="#000"/><text x="90" y="87" font-size="18" text-anchor="middle">?</text> <line x1="124" y1="80" x2="215" y2="80" stroke="#000"/><polygon points="215,80 206,76 206,84" fill="#000"/> <text x="165" y="66" font-size="13" text-anchor="middle">: 4/3</text> <ellipse cx="255" cy="80" rx="34" ry="24" fill="none" stroke="#000"/> <line x1="255" y1="104" x2="255" y2="168" stroke="#000"/><polygon points="255,168 251,159 259,159" fill="#000"/> <text x="275" y="140" font-size="13">. 0,2</text> <ellipse cx="255" cy="200" rx="34" ry="24" fill="none" stroke="#000"/><text x="255" y="206" font-size="16" text-anchor="middle">18</text> <text x="360" y="30" font-size="14" font-weight="bold">4.2</text> <ellipse cx="400" cy="90" rx="32" ry="23" fill="none" stroke="#000"/> <line x1="432" y1="90" x2="498" y2="90" stroke="#000"/><polygon points="498,90 489,86 489,94" fill="#000"/> <text x="465" y="76" font-size="13" text-anchor="middle">. 3/4</text> <ellipse cx="528" cy="90" rx="28" ry="22" fill="none" stroke="#000"/> <line x1="524" y1="112" x2="490" y2="176" stroke="#000"/><polygon points="490,176 494,166 499,172" fill="#000"/> <text x="524" y="150" font-size="13">. 8</text> <ellipse cx="470" cy="200" rx="30" ry="22" fill="none" stroke="#000"/> <line x1="443" y1="188" x2="392" y2="114" stroke="#000"/><polygon points="392,114 401,118 395,123" fill="#000"/> <text x="400" y="165" font-size="13">: ?</text> </svg>',
  'diagramy.svg',
  'Dva diagramy s ovaly spojenymi sipkami s operacemi; v kazdem je jeden otaznik.',
  'Vychozi diagramy k uloze 4',
  new List<String>{'4.1 Z posledniho ovalu: hodnota pred operaci $\\cdot 0{,}2$ je $18:0{,}2=90$. Pred operaci $:\\frac{4}{3}$ je $90\\cdot\\frac{4}{3}=120$. Otaznik je $120$.','4.2 Oznacme levy oval $a$. Pravy oval je $a\\cdot\\frac{3}{4}$, dolni oval je $a\\cdot\\frac{3}{4}\\cdot 8=6a$. Posledni operace $:\\,?$ vrati zpet $a$, tedy $6a:?=a$ a $?=6$.'},
  '4.1: $120$; 4.2: $6$',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2023 - uloha 5.1',
  new List<String>{'V aquaparku je zapujceni zupanu o 30 korun drazsi nez zapujceni osusky. Zapujceni 5 osusek stoji stejne jako zapujceni 3 zupanu. Vypoctete, kolik korun stoji v aquaparku zapujceni jednoho zupanu.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Oznacme cenu osusky $o$; zupan stoji $o+30$. Plati $5o=3(o+30)=3o+90$, tedy $2o=90$ a $o=45$. Zupan stoji $45+30=75$ korun.'},
  '$75$ korun',
  2, 4, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2023 - uloha 5.2',
  new List<String>{'Na plaveckem treninku uplavali Jirka, Misa a Pavla dohromady 126 bazenu. Misa uplavala o tretinu vice bazenu nez Jirka a dvakrat vice bazenu nez Pavla. Vypoctete, kolik bazenu uplavala na treninku Misa.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Necht Misa uplavala $m$ bazenu. Protoze $m$ je o tretinu vice nez pocet Jirky, uplavala Jirka $\\frac{3}{4}m$; Pavla uplavala $\\frac{1}{2}m$. Soucet $\\frac{3}{4}m+m+\\frac{1}{2}m=\\frac{9}{4}m=126$, odtud $m=56$.'},
  '$56$ bazenu',
  2, 4, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2023 - uloha 6',
  new List<String>{'Sest kamaradu si v mobilni aplikaci posilalo ruzne vzkazy. Vytvorili si mezi sebou jednak vsechny mozne peticlenne skupiny, jednak vsechny mozne dvouclenne skupiny.','6.1 Urcete, kolik vytvorili peticlennych skupin.','6.2 Urcete, kolik vytvorili dvouclennych skupin.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Peticlenna skupina vznikne vynechanim jednoho ze sesti kamaradu, takovych skupin je $6$.','6.2 Dvouclennych skupin je $\\frac{6\\cdot 5}{2}=15$.'},
  '6.1: $6$ peticlennych skupin; 6.2: $15$ dvouclennych skupin',
  3, 3, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
