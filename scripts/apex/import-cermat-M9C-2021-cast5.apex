String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, náhradní termín (M9C)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2021 M9C · úloha 13',
  new List<String>{'Kolmý šestiboký hranol byl vytvořen opracováním krychle o hraně délky $8\\ \\mathrm{cm}$. Podstava hranolu vznikne ze čtvercové stěny původní krychle oddělením $4$ shodných pravoúhlých trojúhelníků s odvěsnami délek $3\\ \\mathrm{cm}$ a $4\\ \\mathrm{cm}$. Výška hranolu je $8\\ \\mathrm{cm}$.','Jaký je objem šestibokého hranolu?'},
  new List<String>{'A) $128\\ \\mathrm{cm}^3$','B) $320\\ \\mathrm{cm}^3$','C) $416\\ \\mathrm{cm}^3$','D) $488\\ \\mathrm{cm}^3$','E) jiný objem'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 187 204"><path d="M140 175C140 178 138 180 136 180L76 180C74 180 72 182 72 184C72 182 70 180 68 180L8 180C6 180 4 178 4 175" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M4 37L140 37L140 173L4 173Z" style="fill:#f2f2f2;stroke:#a6a6a6;stroke-width:2"/><path d="M4 105L55 37L89 37L140 105L89 173L55 173L4 105Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><text x="73" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Podstava hranolu</text><text x="116" y="35" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3 cm</text><text x="159" y="77" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4 cm</text><text x="73" y="198" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8 cm</text></svg>',
  'obr.svg',
  'Podstava hranolu: čtverec o straně 8 cm, z jehož čtyř rohů jsou odděleny pravoúhlé trojúhelníky s odvěsnami 3 cm a 4 cm, čímž vznikne šestiúhelník.',
  '',
  new List<String>{'Obsah podstavy $=$ obsah čtverce $-$ $4$ trojúhelníky $=8^2-4\\cdot\\frac{3\\cdot4}{2}=64-24=40\\ \\mathrm{cm}^2$.','Objem $V=S_p\\cdot v=40\\cdot8=320\\ \\mathrm{cm}^3$.'},
  'B) $320\\ \\mathrm{cm}^3$',
  2, 3, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','vyber','bez-kalkulacky'},
  'M9PCD21C0T03', 2021
);
c.add(
  'CERMAT 2021 M9C · úloha 14',
  new List<String>{'Kolmý šestiboký hranol (viz úloha 13): podstava vznikla ze čtvercové stěny krychle o hraně $8\\ \\mathrm{cm}$ oddělením $4$ shodných pravoúhlých trojúhelníků s odvěsnami $3\\ \\mathrm{cm}$ a $4\\ \\mathrm{cm}$, výška hranolu je $8\\ \\mathrm{cm}$.','Jaký je povrch šestibokého hranolu?'},
  new List<String>{'A) $160\\ \\mathrm{cm}^2$','B) $192\\ \\mathrm{cm}^2$','C) $240\\ \\mathrm{cm}^2$','D) $272\\ \\mathrm{cm}^2$','E) $336\\ \\mathrm{cm}^2$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 187 204"><path d="M140 175C140 178 138 180 136 180L76 180C74 180 72 182 72 184C72 182 70 180 68 180L8 180C6 180 4 178 4 175" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M4 37L140 37L140 173L4 173Z" style="fill:#f2f2f2;stroke:#a6a6a6;stroke-width:2"/><path d="M4 105L55 37L89 37L140 105L89 173L55 173L4 105Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><text x="73" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Podstava hranolu</text><text x="116" y="35" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3 cm</text><text x="159" y="77" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4 cm</text><text x="73" y="198" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8 cm</text></svg>',
  'obr.svg',
  'Podstava hranolu: čtverec o straně 8 cm, z jehož čtyř rohů jsou odděleny pravoúhlé trojúhelníky s odvěsnami 3 cm a 4 cm, čímž vznikne šestiúhelník.',
  '',
  new List<String>{'Podstava má obsah $40\\ \\mathrm{cm}^2$ (viz úloha 13). Strany šestiúhelníku: dvě rovnoběžné strany délky $8-2\\cdot3=2\\ \\mathrm{cm}$ a čtyři přepony $\\sqrt{3^2+4^2}=5\\ \\mathrm{cm}$; obvod podstavy $o=2\\cdot2+4\\cdot5=24\\ \\mathrm{cm}$.','Povrch $S=2\\cdot S_p+o\\cdot v=2\\cdot40+24\\cdot8=80+192=272\\ \\mathrm{cm}^2$.'},
  'D) $272\\ \\mathrm{cm}^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','vypocet','vyber','bez-kalkulacky'},
  'M9PCD21C0T03', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
