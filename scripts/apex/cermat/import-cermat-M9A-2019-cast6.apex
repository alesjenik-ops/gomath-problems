String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M9A 2019 – úloha 14',
  new List<String>{'Krychle byla slepena z $27$ malých bílých krychliček o hraně délky $2$ cm. Dvě malé krychličky jsme odstranili (jednu z hrany a jednu ze středu stěny), a vzniklo tak nové těleso. Všechny dostupné plochy nového tělesa jsme obarvili na šedo (i zespodu) – viz obrázek.','Jaký je celkový obsah šedých ploch nového tělesa?'},
  new List<String>{'A) menší než $236$ cm²','B) $236$ cm²','C) $240$ cm²','D) $244$ cm²','E) větší než $244$ cm²'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 300" font-family="sans-serif"> <polygon points="40,120 190,120 245,75 95,75" fill="#d9d9d9" stroke="#000"/> <polygon points="190,120 245,75 245,225 190,270" fill="#bfbfbf" stroke="#000"/> <rect x="40" y="120" width="150" height="150" fill="#ededed" stroke="#000"/> <line x1="90" y1="120" x2="90" y2="270" stroke="#000"/> <line x1="140" y1="120" x2="140" y2="270" stroke="#000"/> <line x1="40" y1="170" x2="190" y2="170" stroke="#000"/> <line x1="40" y1="220" x2="190" y2="220" stroke="#000"/> <line x1="130" y1="120" x2="185" y2="75" stroke="#000"/> <line x1="80" y1="120" x2="135" y2="75" stroke="#000"/> <line x1="95" y1="75" x2="95" y2="225" stroke="#000" stroke-opacity="0"/> <line x1="190" y1="170" x2="245" y2="125" stroke="#000"/> <line x1="190" y1="220" x2="245" y2="175" stroke="#000"/> <rect x="99" y="179" width="32" height="32" fill="#ffffff" stroke="#000"/> <polygon points="245,75 245,125 210,110 210,60" fill="#ffffff" stroke="#000"/> <text x="150" y="292" font-size="12" text-anchor="middle">nové těleso (2 krychličky odebrány)</text> </svg>',
  'krychle-teleso.svg',
  'Krychle složená z 3 krát 3 krát 3 krychliček, ze které jsou odebrány dvě krychličky (jedna z hrany, jedna ze středu stěny); schematický nákres.',
  'Nové těleso po odebrání dvou krychliček',
  new List<String>{'Velká krychle má hranu $3\\cdot 2 = 6$ cm, její povrch je $6\\cdot 6^2 = 216$ cm². Jedna malá stěna má obsah $2\\cdot 2 = 4$ cm². Odebráním krychličky ze středu stěny (jedna její stěna byla na povrchu) se odkryje $5$ vnitřních stěn a jedna povrchová zmizí, tj. přibude $5\\cdot 4 - 4 = 16$ cm². Odebráním krychličky z hrany (dvě její stěny byly na povrchu) přibude $4\\cdot 4 - 2\\cdot 4 = 8$ cm². Celkem $216 + 16 + 8 = 240$ cm².'},
  'C) $240$ cm²',
  2, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Cena jedné židle se snížila o $25\\,\\%$ na $1\\,800$ korun. Kolik korun stála jedna židle před snížením ceny?','15.2 Výrobek po zdražení o $20\\,\\%$ stojí $2\\,700$ korun. Kolik korun stál výrobek před zdražením?','15.3 Jana na lyžařské brýle přispěla $40\\,\\%$, chybějících $900$ korun za lyžařské brýle doplatil strýc. Cena za lyžařské brýle tvořila $60\\,\\%$ celé útraty za nákup lyžařských doplňků. Kolik korun činila celá útrata za nákup lyžařských doplňků?'},
  new List<String>{'A) $2\\,160$ korun','B) $2\\,250$ korun','C) $2\\,340$ korun','D) $2\\,400$ korun','E) $2\\,500$ korun','F) jiný počet korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 $1\\,800$ Kč odpovídá $75\\,\\%$ původní ceny; $100\\,\\% = \\frac{1\\,800}{0{,}75} = 2\\,400$ Kč → D.','15.2 $2\\,700$ Kč odpovídá $120\\,\\%$ původní ceny; $100\\,\\% = \\frac{2\\,700}{1{,}2} = 2\\,250$ Kč → B.','15.3 Strýc doplatil $60\\,\\%$ ceny brýlí $= 900$ Kč, takže brýle stály $\\frac{900}{0{,}6} = 1\\,500$ Kč. Brýle tvoří $60\\,\\%$ celé útraty, tedy útrata $= \\frac{1\\,500}{0{,}6} = 2\\,500$ Kč → E.'},
  '15.1: D ($2\\,400$ korun); 15.2: B ($2\\,250$ korun); 15.3: E ($2\\,500$ korun)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
