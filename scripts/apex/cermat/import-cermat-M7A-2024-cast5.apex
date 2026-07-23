String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD24C0T01';
Integer YEAR = 2024;

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
  'CERMAT M7A 2024 – úloha 13',
  new List<String>{'Kolikrát je obsah obdélníku o straně $a=36$ cm a straně $b=12$ cm větší než obsah čtverce se stranou délky $6$ cm?'},
  new List<String>{'A) $3$krát','B) $6$krát','C) $7{,}5$krát','D) $12$krát','E) $12{,}5$krát'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Obsah obdélníku $36\\cdot 12=432$ cm², obsah čtverce $6\\cdot 6=36$ cm². Podíl $432:36=12$.'},
  'D) $12$krát',
  2, 2, '1',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2024 – úloha 14',
  new List<String>{'Přímky $m$, $n$ jsou rovnoběžné (viz obrázek). V obrázku jsou vyznačeny úhly $\\alpha$, $105^\\circ$, $\\beta$ a $2\\beta$.','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočítejte (obrázek je ilustrační).'},
  new List<String>{'A) $145^\\circ$','B) $110^\\circ$','C) $105^\\circ$','D) $75^\\circ$','E) $35^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif"> <line x1="60" y1="120" x2="300" y2="320" stroke="#000" stroke-width="2"/> <line x1="200" y1="40" x2="440" y2="240" stroke="#000" stroke-width="2"/> <line x1="30" y1="240" x2="470" y2="240" stroke="#000" stroke-width="2"/> <line x1="250" y1="40" x2="410" y2="300" stroke="#000" stroke-width="2"/> <text x="52" y="116" font-size="16" font-style="italic">n</text> <text x="192" y="36" font-size="16" font-style="italic">m</text> <text x="252" y="36" font-size="16" font-style="italic">r</text> <text x="478" y="245" font-size="16" font-style="italic">p</text> <text x="298" y="168" font-size="17">α</text> <text x="166" y="226" font-size="15">105°</text> <text x="176" y="264" font-size="16">2β</text> <text x="350" y="228" font-size="16">β</text> </svg>',
  'rovnobezky-uhly.svg',
  'Dve rovnobezne primky m, n a dve pricky r, p; vyznacene uhly alfa, 105 stupnu, beta a 2beta.',
  'Ilustrační obrázek k úloze 14',
  new List<String>{'Z úhlů u přímky s vyznačeným úhlem $105^\\circ$ plyne $3\\beta=105^\\circ$, tedy $\\beta=35^\\circ$ a $2\\beta=70^\\circ$. Úhel $\\alpha$ je přilehlý k úhlu $2\\beta$ u rovnoběžek $m$, $n$ (jejich součet je $180^\\circ$), takže $\\alpha=180^\\circ-70^\\circ=110^\\circ$.'},
  'B) $110^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2024 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1-15.3) odpovídající výsledek (A-F).','15.1 Koupaliště během letošního léta navštívilo $680$ návštěvníků, což je $80\\,\\%$ všech návštěvníků za celý minulý rok. Kolik návštěvníků přišlo na koupaliště v loňském roce?','15.2 S cestovní kanceláří vycestovalo v červnu $330$ klientů, což bylo o $40\\,\\%$ méně než v měsíci červenci. Kolik klientů vycestovalo s cestovní kanceláří v červenci?','15.3 Na mapě s měřítkem $1:3\\,000$ je vyznačen čtvercový pozemek o straně $15$ cm. Jaká je skutečná délka strany tohoto pozemku v metrech?'},
  new List<String>{'A) $450$','B) $550$','C) $650$','D) $750$','E) $850$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 $680$ je $80\\,\\%$, tj. $100\\,\\%=680:0{,}8=850$ - E.','15.2 $330$ je $60\\,\\%$ červencové hodnoty, tj. $330:0{,}6=550$ - B.','15.3 $15$ cm $\\cdot\\,3\\,000=45\\,000$ cm $=450$ m - A.'},
  '15.1: E ($850$); 15.2: B ($550$); 15.3: A ($450$)',
  6, 7, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
