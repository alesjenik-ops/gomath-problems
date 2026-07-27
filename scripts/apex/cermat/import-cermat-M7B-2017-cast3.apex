String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M7B 2017 – úloha 8',
  new List<String>{'V akváriu tvaru kvádru se čtvercovou podstavou je voda napuštěna do výšky $2$ dm. Dno akvária má obsah $36$ dm².','8.1 Vypočtěte v litrech objem vody v akváriu.','8.2 Vypočtěte v dm² obsah všech ploch smáčených vodou (tj. dna a částí stěn).'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 330 210" font-family="sans-serif"> <polygon points="60,110 230,110 285,70 115,70" fill="#c9c9c9" stroke="#000"/> <rect x="60" y="110" width="170" height="70" fill="#c9c9c9" stroke="#000"/> <polygon points="230,110 285,70 285,140 230,180" fill="#b0b0b0" stroke="#000"/> <polyline points="60,180 115,100 285,140" fill="none" stroke="#000" stroke-width="2" stroke-dasharray="6 5"/> <polyline points="60,60 60,180 230,180 230,60" fill="none" stroke="#000" stroke-width="2"/> <polyline points="60,60 115,20 285,20 230,60" fill="none" stroke="#000" stroke-width="2"/> <polyline points="115,20 115,100" fill="none" stroke="#000" stroke-width="2"/> <polyline points="285,20 285,140 230,180" fill="none" stroke="#000" stroke-width="2"/> <line x1="230" y1="60" x2="285" y2="20" stroke="#000" stroke-width="2"/> </svg>',
  'akvarium.svg',
  'Akvárium tvaru kvádru se čtvercovou podstavou, voda vyplňuje spodní část a její hladina je vyznačena.',
  'Akvárium tvaru kvádru (schematicky)',
  new List<String>{'8.1 $V=S_{\\text{dna}}\\cdot h=36\\cdot 2=72$ dm³ $=72$ litrů.','8.2 Podstava je čtverec o obsahu $36$ dm², tedy strana měří $6$ dm.','Smáčené jsou dno a čtyři obdélníky $6\\times 2$ dm: $36+4\\cdot 12=36+48=84$ dm².'},
  '8.1: $72$ litrů; 8.2: $84$ dm²',
  3, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2017 – úloha 9',
  new List<String>{'V rovině leží rovnoběžník $ABCD$ (viz obrázek).','9.1 Sestrojte střed $S$ rovnoběžníku $ABCD$.','9.2 V rovnoběžníku $ABCD$ sestrojte všechny jeho výšky procházející středem $S$.','9.3 V sestrojeném obrázku najděte a vyznačte libovolné dva pravé úhly.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 320" font-family="sans-serif"> <polygon points="250,40 420,110 250,270 80,200" fill="none" stroke="#000" stroke-width="2.5"/> <text x="245" y="30" font-size="17" font-style="italic">C</text> <text x="432" y="112" font-size="17" font-style="italic">B</text> <text x="248" y="292" font-size="17" font-style="italic">A</text> <text x="58" y="204" font-size="17" font-style="italic">D</text> </svg>',
  'rovnobeznik-ABCD.svg',
  'Rovnoběžník ABCD s vrcholem C nahoře, B vpravo, A dole a D vlevo.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'9.1 Střed $S$ je průsečík úhlopříček $AC$ a $BD$.','9.2 Bodem $S$ vedeme kolmici ke straně $AB$ (a tím i ke straně $CD$) – výška $v_a$ – a kolmici ke straně $BC$ (a tím i ke straně $AD$) – výška $v_b$. Obě výšky procházejí středem $S$.','9.3 Pravé úhly jsou v patách obou výšek, tj. tam, kde výšky protínají strany rovnoběžníku; vyznačíme libovolné dva z nich.'},
  'Střed $S$ = průsečík úhlopříček $AC$ a $BD$; obě výšky $v_a$ (kolmá k $AB$ a $CD$) a $v_b$ (kolmá k $BC$ a $AD$) vedené bodem $S$; vyznačené dva pravé úhly v patách výšek – viz obrázek v klíči.',
  3, 7, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
