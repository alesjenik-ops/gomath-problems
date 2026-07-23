String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD22C0T02';
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
  'CERMAT M7B 2022 – úloha 13',
  new List<String>{'Obdélník je rozdělen na $12$ čtverců čtyř různých velikostí ($S$, $M$, $L$ a $XL$). Delší strana obdélníku měří $260$ cm.','Jaký je obvod čtverce velikosti $L$?'},
  new List<String>{'A) $240$ cm','B) $280$ cm','C) $320$ cm','D) $360$ cm','E) jiný obvod'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 260" font-family="sans-serif" font-size="15"> <rect x="40" y="30" width="390" height="180" fill="none" stroke="#000" stroke-width="1.6"/> <line x1="250" y1="30" x2="250" y2="210" stroke="#000"/> <text x="340" y="128" text-anchor="middle">XL</text> <rect x="40" y="30" width="110" height="110" fill="none" stroke="#000"/> <text x="95" y="92" text-anchor="middle">L</text> <rect x="150" y="30" width="36" height="36" fill="none" stroke="#000"/> <rect x="150" y="66" width="36" height="36" fill="none" stroke="#000"/> <rect x="150" y="102" width="36" height="38" fill="none" stroke="#000"/> <rect x="186" y="104" width="30" height="30" fill="none" stroke="#000"/> <text x="201" y="124" text-anchor="middle" font-size="11">S</text> <line x1="40" y1="140" x2="250" y2="140" stroke="#000"/> <line x1="145" y1="140" x2="145" y2="210" stroke="#000"/> <text x="92" y="180" text-anchor="middle">M</text> <text x="198" y="180" text-anchor="middle">M</text> <line x1="40" y1="230" x2="430" y2="230" stroke="#000"/> <line x1="40" y1="226" x2="40" y2="234" stroke="#000"/> <line x1="430" y1="226" x2="430" y2="234" stroke="#000"/> <text x="235" y="250" text-anchor="middle">260 cm</text> </svg>',
  'obdelnik-ctverce.svg',
  'Schematický nákres obdélníku rozděleného na dvanáct čtverců čtyř velikostí (S, M, L, XL); delší strana obdélníku měří 260 cm.',
  'Rozdělení obdélníku na 12 čtverců čtyř velikostí (schematicky)',
  new List<String>{'Z rozdělení obdélníku (delší strana $260$ cm) na dvanáct čtverců čtyř velikostí vyplývá, že čtverec velikosti $L$ má stranu $80$ cm. Jeho obvod je $4\\cdot80=320$ cm.'},
  'C) $320$ cm',
  2, 5, '4',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2022 – úloha 14',
  new List<String>{'V pohádkové říši se setkání draků zúčastnili pouze dvouhlaví a tříhlaví draci. Draků bylo celkem $52$ a dohromady měli $134$ hlav.','O kolik se liší součet hlav všech tříhlavých draků od součtu hlav všech dvouhlavých draků?'},
  new List<String>{'A) o méně než $22$ hlav','B) o $22$ hlav','C) o $30$ hlav','D) o $41$ hlav','E) o více než $41$ hlav'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Dvouhlavých draků je $d_2$, tříhlavých $d_3$: $d_2+d_3=52$ a $2d_2+3d_3=134$. Odtud $d_3=134-2\\cdot52=30$ a $d_2=22$. Součet hlav tříhlavých je $3\\cdot30=90$, dvouhlavých $2\\cdot22=44$; liší se o $90-44=46$ hlav, což je více než $41$.'},
  'E) o více než $41$ hlav',
  2, 3, '2',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2022 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Ze sklizené mrkve se prodalo $960$ kg, a zbývalo tak ještě $40\\,\\%$ sklizené mrkve. Kolik kg mrkve bylo sklizeno?','15.2 Během prosince ze skladu odvezli pětinu posypové soli, a ve skladu tak zbylo ještě $9\\,000$ kg posypové soli. Kolik kg posypové soli odvezli ze skladu během prosince?','15.3 Obchodník nakoupil $12\\,000$ kg brambor. V říjnu z nich prodal $40\\,\\%$, v listopadu prodal $75\\,\\%$ zbytku a neprodané brambory daroval charitě. Kolik kg brambor daroval obchodník charitě?'},
  new List<String>{'A) $1\\,600$ kg','B) $1\\,800$ kg','C) $2\\,000$ kg','D) $2\\,250$ kg','E) $2\\,400$ kg','F) více než $2\\,400$ kg'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Prodaných $960$ kg je $60\\,\\%$ sklizně (zbývá $40\\,\\%$), sklizeno $960:0{,}6=1600$ kg → A.','15.2 Odvezena $\\frac{1}{5}$, zbylé $\\frac{4}{5}$ jsou $9000$ kg, celkem $11\\,250$ kg; odvezeno $\\frac{1}{5}\\cdot11\\,250=2250$ kg → D.','15.3 V říjnu prodáno $40\\,\\%$ z $12\\,000$ kg, zbývá $7200$ kg; v listopadu prodáno $75\\,\\%$, neprodáno $25\\,\\%$ z $7200=1800$ kg → B.'},
  '15.1: A ($1\\,600$ kg); 15.2: D ($2\\,250$ kg); 15.3: B ($1\\,800$ kg)',
  6, 8, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
