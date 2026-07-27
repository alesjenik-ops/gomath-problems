String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD17C0T02';
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
  'CERMAT M5B 2017 – úloha 12',
  new List<String>{'Letos do taneční skupiny přibylo 6 dívek a 6 chlapců. Oproti předešlému roku se tak počet dívek zvýšil o polovinu a počet chlapců na dvojnásobek.','Kolik dětí je letos v taneční skupině?'},
  new List<String>{'A) méně než 20 dětí','B) 20 dětí','C) 25 dětí','D) 30 dětí','E) jiný počet dětí'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Dívky: $d + 6 = 1{,}5\\,d$, tedy $d = 12$ (loni), letos $18$. Chlapci: $ch + 6 = 2\\,ch$, tedy $ch = 6$ (loni), letos $12$. Celkem letos $18 + 12 = 30$ dětí.'},
  'D) 30 dětí',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2017 – úloha 13',
  new List<String>{'Čtyři různé díly stavebnice jsou složené z 1–4 kostek (první díl 1 kostka, druhý díl 2 kostky, třetí díl 3 kostky ve tvaru L, čtvrtý díl 4 kostky). Z těchto dílů lze několika způsoby postavit pět zobrazených staveb (viz obrázek).','Vyberte všechny stavby, které splňují danou podmínku (13.1–13.3), a uveďte jejich počet (A–F).','13.1 Stavbu je možné postavit jen z druhých dílů stavebnice.','13.2 Ve stavbě je možné použít čtvrtý díl stavebnice.','13.3 Ve stavbě je možné použít dvakrát třetí díl stavebnice (a případně i jiné díly).'},
  new List<String>{'A) pět staveb','B) čtyři stavby','C) tři stavby','D) dvě stavby','E) jedna stavba','F) žádná stavba'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif"> <text x="280" y="55" font-size="13" text-anchor="middle">Čtyři díly stavebnice (1 až 4 kostky) a pět staveb z krychliček.</text> <text x="280" y="80" font-size="11" text-anchor="middle" fill="#666">Prostorové stavby nelze věrně přenést do SVG; posuzuje se podle originálu.</text> </svg>',
  'stavebnice.svg',
  'Čtyři díly stavebnice z 1 až 4 kostek a pět staveb z nich složených.',
  'Díly stavebnice a pět staveb (viz testový sešit)',
  new List<String>{'13.1 Jen z dvojkostkových dílů (druhých dílů) lze složit čtyři z pěti staveb → B.','13.2 Čtyřkostkový čtvrtý díl lze použít u dvou staveb → D.','13.3 Dvakrát třetí díl (dvě L-trojkostky) lze použít u tří staveb → C.'},
  '13.1: B (čtyři stavby); 13.2: D (dvě stavby); 13.3: C (tři stavby)',
  5, 5, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2017 – úloha 14',
  new List<String>{'Uvnitř šedého čtverce je umístěn bílý čtverec. Vrcholy bílého čtverce rozdělují každou stranu šedého čtverce na dva úseky dlouhé 1 cm a 2 cm (viz obrázek).','Obdobným způsobem se umístí větší počet stejných bílých čtverců v řadě do šedého obdélníku. S přibývajícím počtem bílých čtverců se mění délky stran šedého obdélníku. Rozměry jsou v cm.','14.1 Určete délky stran šedého obdélníku se dvěma bílými čtverci.','14.2 Určete délky stran šedého obdélníku s pěti bílými čtverci.','14.3 Delší strana šedého obdélníku měří 85 cm. Určete délku kratší strany tohoto obdélníku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 240" font-family="sans-serif"> <rect x="45" y="45" width="150" height="150" fill="#cccccc" stroke="#000" stroke-width="1.5"/> <polygon points="95,45 195,95 145,195 45,145" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <text x="70" y="38" font-size="14" text-anchor="middle">1</text> <text x="145" y="38" font-size="14" text-anchor="middle">2</text> <text x="34" y="80" font-size="14" text-anchor="middle">2</text> <text x="34" y="165" font-size="14" text-anchor="middle">1</text> <text x="206" y="150" font-size="14" text-anchor="middle">2</text> <text x="120" y="214" font-size="14" text-anchor="middle">1</text> </svg>',
  'ctverce.svg',
  'Šedý čtverec s vepsaným pootočeným bílým čtvercem; vrcholy dělí strany na úseky 1 cm a 2 cm.',
  'Šedý čtverec s bílým čtvercem (rozměry v cm)',
  new List<String>{'S jedním bílým čtvercem je šedý útvar čtverec $3\\times 3$ cm. Každý další bílý čtverec prodlouží delší stranu o $2$ cm; pro $n$ bílých čtverců je kratší strana $n + 2$ cm a delší strana $2n + 1$ cm.','14.1 Pro $n = 2$: kratší strana $4$ cm, delší strana $5$ cm.','14.2 Pro $n = 5$: kratší strana $7$ cm, delší strana $11$ cm.','14.3 Z $2n + 1 = 85$ je $n = 42$, kratší strana $n + 2 = 44$ cm.'},
  '14.1: $4$ cm, $5$ cm; 14.2: $7$ cm, $11$ cm; 14.3: $44$ cm',
  4, 6, '3',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
