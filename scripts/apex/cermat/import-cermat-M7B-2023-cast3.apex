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
  'CERMAT M7B 2023 - uloha 7',
  new List<String>{'Kolmy ctyrboky hranol ma vysku 20 cm. Podstavou hranolu je kosodelnik s obvodem 30 cm. Delka jedne strany kosodelniku je 7 cm a vyska kosodelniku na sousedni stranu meri 6 cm.','7.1 Vypoctete v cm soucet delek vsech hran hranolu.','7.2 Vypoctete v cm3 objem hranolu.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 280" font-family="sans-serif"> <text x="110" y="30" font-size="13" text-anchor="middle">Podstava (kosodelnik)</text> <polygon points="50,160 150,160 120,110 20,110" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="50" y1="160" x2="50" y2="110" stroke="#000" stroke-width="1" stroke-dasharray="4 3"/> <rect x="50" y="152" width="8" height="8" fill="none" stroke="#000"/> <text x="30" y="138" font-size="12">6 cm</text> <text x="140" y="140" font-size="12">7 cm</text> <text x="365" y="30" font-size="13" text-anchor="middle">Hranol</text> <polygon points="330,245 430,245 400,195 300,195" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="330,95 430,95 400,45 300,45" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="330" y1="245" x2="330" y2="95" stroke="#000" stroke-width="1.5"/> <line x1="430" y1="245" x2="430" y2="95" stroke="#000" stroke-width="1.5"/> <line x1="400" y1="195" x2="400" y2="45" stroke="#000" stroke-width="1.5"/> <line x1="300" y1="195" x2="300" y2="45" stroke="#000" stroke-width="1" stroke-dasharray="4 3"/> <text x="437" y="175" font-size="12">20 cm</text> <text x="372" y="240" font-size="12">7 cm</text> </svg>',
  'hranol.svg',
  'Kosodelnik se stranou 7 cm a vyskou 6 cm a kolmy ctyrboky hranol vysky 20 cm.',
  'Schematicky nakres podstavy a hranolu',
  new List<String>{'7.1 Strany kosodelniku jsou 7 cm a 8 cm, protoze $2\\cdot(7+8)=30$. Hranol ma 8 podstavnych hran o souctu $2\\cdot 30=60$ cm a 4 bocni hrany po 20 cm o souctu $80$ cm. Celkem $60+80=140$ cm.','7.2 Obsah podstavy je $8\\cdot 6=48$ cm2 (strana 8 cm a prislusna vyska 6 cm). Objem je $48\\cdot 20=960$ cm3.'},
  '7.1: $140$ cm; 7.2: $960$ cm3',
  4, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2023 - uloha 8 (konstrukce)',
  new List<String>{'V rovine lezi bod $F$ a primka $g$ (viz obrazek).','Bod $F$ je vrchol rovnoramenneho trojuhelniku $EFG$. Strana $EF$ tohoto trojuhelniku meri 5 cm a lezi na kolmici k primce $g$. Na primce $g$ lezi vrchol $G$ trojuhelniku $EFG$.','Sestrojte vrcholy $E$, $G$ trojuhelniku $EFG$, oznacte je pismeny a trojuhelnik narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif"> <line x1="60" y1="90" x2="420" y2="150" stroke="#000" stroke-width="2"/> <text x="428" y="152" font-size="16" font-style="italic">g</text> <text x="178" y="236" font-size="15" font-style="italic">F</text> <text x="193" y="229" font-size="14">x</text> </svg>',
  'bod-F-primka-g.svg',
  'Bod F a primka g mirne klesajici zleva doprava.',
  'Vychozi obrazek k uloze 8',
  new List<String>{'Sestrojime kruznici se stredem $F$ a polomerem 5 cm. Vrchol $E$ je prusecik teto kruznice s kolmici spustenou z bodu $F$ k primce $g$ (na strane primky $g$). Vrchol $G$ je prusecik kruznice s primkou $g$; jsou dve polohy $G_1$ a $G_2$, trojuhelnik $EFG$ je rovnoramenny, protoze $|FE|=|FG|=5$ cm. Uloha ma dve reseni.'},
  'Dve reseni: $|FE|=|FG|=5$ cm; bod $E$ na kolmici z $F$ k primce $g$, vrcholy $G_1$ a $G_2$ jako pruseciky kruznice se stredem $F$ a polomerem 5 cm s primkou $g$ (viz nakres v klici).',
  3, 6, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
