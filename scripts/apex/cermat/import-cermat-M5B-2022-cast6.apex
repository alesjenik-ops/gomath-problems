String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD22C0T02';
Integer YEAR = 2022;

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
  'CERMAT M5B 2022 – úloha 11',
  new List<String>{'Obdélník je rozdělen na 12 čtverců čtyř různých velikostí (S, M, L a XL). Delší strana obdélníku měří 260 cm.','Jaký je obvod čtverce velikosti L?'},
  new List<String>{'A) méně než $320$ cm','B) $320$ cm','C) $360$ cm','D) $400$ cm','E) více než $400$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif"> <rect x="30" y="30" width="460" height="200" fill="none" stroke="#000" stroke-width="2"/> <rect x="30" y="30" width="30" height="30" fill="none" stroke="#000"/> <rect x="30" y="60" width="30" height="30" fill="none" stroke="#000"/> <rect x="30" y="90" width="30" height="30" fill="none" stroke="#000"/> <rect x="30" y="120" width="30" height="30" fill="none" stroke="#000"/> <rect x="60" y="30" width="120" height="120" fill="#f4f4f4" stroke="#000"/><text x="120" y="95" font-size="18" text-anchor="middle">L</text> <rect x="60" y="150" width="30" height="30" fill="none" stroke="#000"/><text x="75" y="170" font-size="11" text-anchor="middle">S</text> <rect x="90" y="150" width="90" height="90" fill="#eaeaea" stroke="#000"/><text x="135" y="200" font-size="16" text-anchor="middle">M</text> <rect x="30" y="150" width="30" height="30" fill="none" stroke="#000"/> <rect x="30" y="180" width="30" height="60" fill="none" stroke="#000"/> <rect x="180" y="30" width="200" height="200" fill="#f4f4f4" stroke="#000"/><text x="280" y="135" font-size="22" text-anchor="middle">XL</text> <rect x="380" y="30" width="110" height="110" fill="none" stroke="#000"/> <rect x="380" y="140" width="110" height="90" fill="none" stroke="#000"/> <line x1="30" y1="255" x2="490" y2="255" stroke="#000"/> <line x1="30" y1="250" x2="30" y2="260" stroke="#000"/><line x1="490" y1="250" x2="490" y2="260" stroke="#000"/> <text x="260" y="275" font-size="14" text-anchor="middle">260 cm</text> </svg>',
  'obdelnik-ctverce.svg',
  'Obdélník s delší stranou 260 cm rozdělený na čtverce velikostí S, M, L a XL (schematicky).',
  'Schematické rozdělení obdélníku na čtverce',
  new List<String>{'Ze vzájemných poměrů stran čtverců v nákresu vychází strana čtverce velikosti L rovna $80$ cm. Obvod čtverce L je $4\\cdot 80=320$ cm.'},
  'B) $320$ cm',
  2, 4, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2022 – úloha 12',
  new List<String>{'Petr postavil na podložce stavbu ze 13 stejných krychliček (viz obrázek). Každá z pěti staveb (A–E) byla postavena na podložce ze 14 stejných krychliček. V každé stavbě (i v Petrově) jsou sousední krychličky vždy slepeny k sobě.','Kterou ze staveb A–E lze spojit s Petrovou stavbou tak, že vznikne krychle?'},
  new List<String>{'A) stavba A','B) stavba B','C) stavba C','D) stavba D','E) stavba E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif"> <text x="280" y="50" font-size="13" text-anchor="middle">Petrova stavba (13 krychliček) a stavby A-E (po 14 krychličkách) - prostorová tělesa.</text> <text x="280" y="76" font-size="12" text-anchor="middle" fill="#666">Spojením Petrovy stavby a jedné ze staveb A-E vznikne krychle 3x3x3 (27 krychliček).</text> <text x="280" y="100" font-size="12" text-anchor="middle" fill="#666">Tělesa nelze věrně přenést do SVG; posuzuje se podle originálu v testovém sešitu.</text> </svg>',
  'stavby-krychle.svg',
  'Petrova stavba ze 13 krychliček a pět staveb A–E po 14 krychličkách (schematická poznámka).',
  'Prostorové stavby – viz testový sešit',
  new List<String>{'Petrova stavba má 13 krychliček, hledaná stavba 14; dohromady $13+14=27=3^3$, tedy krychle $3\\times 3\\times 3$. Doplňkem Petrovy stavby na krychli je stavba D.'},
  'D) stavba D',
  2, 3, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
