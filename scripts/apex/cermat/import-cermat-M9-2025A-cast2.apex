String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M9A 2025 - uloha 5',
  new List<String>{'Na obrazku je planek pozemku, na kterem se nachazi dum a rybnicek. Pozemek ma tvar ctverce s delkou strany $c=30$ m. Svetle sedy obdelnik predstavuje pudorys domu a tmavsi obrazec predstavuje rybnicek. Pudorys domu ma petkrat mensi obsah, nez je celkova rozloha pozemku.','5.1 Delka domu $a$ je rovna polovine delky strany pozemku $c$. Urcete sirku domu $b$.','5.2 Rozloha rybnicku predstavuje $18\\,\\%$ celkove rozlohy pozemku. Vypoctete v m2 rozlohu volne casti pozemku, na niz neni ani dum, ani rybnicek.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 300" font-family="sans-serif"> <rect x="50" y="30" width="240" height="240" fill="none" stroke="#000" stroke-width="2"/> <rect x="70" y="50" width="90" height="110" fill="#ededed" stroke="#000"/> <polygon points="200,178 240,168 266,192 258,236 212,246 190,214" fill="#8a8a8a" stroke="#000"/> <text x="166" y="108" font-size="14" font-style="italic">a</text> <text x="110" y="176" font-size="14" font-style="italic">b</text> <text x="298" y="154" font-size="14" font-style="italic">c</text> <text x="167" y="288" font-size="14" font-style="italic">c</text> </svg>',
  'pozemek.svg',
  'Planek ctvercoveho pozemku o strane c; vlevo nahore svetle sedy obdelnik (dum) se stranami a, b, vpravo dole tmavy obrazec (rybnicek).',
  'Schematicky planek pozemku',
  new List<String>{'5.1 Rozloha pozemku $30\\cdot 30=900$ m2. Pudorys domu $900:5=180$ m2. Delka $a=c:2=15$ m, tedy sirka $b=180:15=12$ m.','5.2 Rybnicek $0{,}18\\cdot 900=162$ m2. Volna cast $900-180-162=558$ m2.'},
  '5.1: $b=12$ m; 5.2: $558$ m2',
  4, 6, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2025 - uloha 6',
  new List<String>{'Zahradni sud ma tvar rotacniho valce. Dno sudu ma obsah $1500$ cm2.','6.1 Pri desti stoupla hladina vody v sudu o $10$ mm. Vypoctete, kolik litrU vody pribylo v sudu behem tohoto deste.','6.2 Pri silnem lijaku v sudu pribyly $3$ litry vody. Vypoctete, o kolik mm stoupla hladina vody v sudu behem tohoto silneho lijaku.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 $10$ mm $=1$ cm; objem $=1500\\cdot 1=1500$ cm3 $=1{,}5$ litru.','6.2 $3$ litry $=3000$ cm3; vyska $=3000:1500=2$ cm $=20$ mm.'},
  '6.1: $1{,}5$ litru; 6.2: $20$ mm',
  2, 4, '2',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2025 - uloha 7',
  new List<String>{'V rovine lezi primky $p$, $q$, $r$, ktere se protinaji v bode $R$, a primky $s$, $t$, pro ktere plati $s\\parallel r$ a $s\\perp t$. U bodu $R$ jsou vyznaceny uhly $30^\\circ$ a $130^\\circ$ (viz obrazek).','Vypoctete ve stupnich velikost uhlu:','7.1 $\\alpha$,   7.2 $\\beta$,   7.3 $\\gamma$.','Velikosti uhlU nemerte, ale vypoctete (obrazek je pouze ilustrativni).'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif"> <line x1="70" y1="150" x2="430" y2="150" stroke="#000" stroke-width="1.5"/><text x="436" y="155" font-size="15" font-style="italic">r</text> <line x1="70" y1="240" x2="430" y2="240" stroke="#000" stroke-width="1.5"/><text x="436" y="245" font-size="15" font-style="italic">s</text> <line x1="390" y1="110" x2="390" y2="272" stroke="#000" stroke-width="1.5"/><text x="396" y="285" font-size="15" font-style="italic">t</text> <line x1="150" y1="258" x2="360" y2="50" stroke="#000" stroke-width="1.5"/><text x="150" y="272" font-size="15" font-style="italic">p</text> <line x1="200" y1="272" x2="310" y2="48" stroke="#000" stroke-width="1.5"/><text x="205" y="286" font-size="15" font-style="italic">q</text> <text x="256" y="146" font-size="15" font-style="italic">R</text> <text x="222" y="170" font-size="12">30</text><text x="238" y="170" font-size="10">o</text> <text x="282" y="172" font-size="12">130</text><text x="304" y="172" font-size="10">o</text> <text x="152" y="232" font-size="14">a</text> <text x="222" y="232" font-size="14">b</text> <text x="330" y="92" font-size="14">g</text> <rect x="378" y="228" width="12" height="12" fill="none" stroke="#000"/> <text x="330" y="145" font-size="14">||</text><text x="330" y="236" font-size="14">||</text> </svg>',
  'primky-uhly.svg',
  'Primky p, q, r protinajici se v bode R; rovnobezka s a kolmice t; vyznacene uhly 30 a 130 stupnu a hledane uhly alfa, beta, gama.',
  'Vychozi obrazek k uloze 7 (ilustrativni)',
  new List<String>{'7.1 Protoze $s\\parallel r$, je $\\alpha$ stridavy uhel k vyznacenemu $30^\\circ$, tedy $\\alpha=30^\\circ$.','7.2 Uhel mezi primkou $q$ a primkou $r$ je vedlejsi k vyznacenemu $130^\\circ$, tj. $50^\\circ$; z rovnobeznosti $s\\parallel r$ je $\\beta=50^\\circ$.','7.3 Primka $t$ je kolma k $r$, proto $\\gamma=90^\\circ+\\beta=90^\\circ+50^\\circ=140^\\circ$.'},
  '7.1: $\\alpha=30^\\circ$; 7.2: $\\beta=50^\\circ$; 7.3: $\\gamma=140^\\circ$',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
