String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený C16 – výsledky přijímaček (grafy)',
  new List<String>{'V grafech vidíte výsledky testů sedmi nejlepších dívek a sedmi nejlepších chlapců z naší školy u přijímacích zkoušek na místní gymnázium. V každém z testů bylo možné dosáhnout nejvýše $50$ bodů.','Na základě informací obsažených ve výchozím textu a grafu nahraďte v následujících větách (16.1–16.3) symbol ***** správným výrazem nebo číslem.','16.1 Mezi deseti nejúspěšnějšími z naší školy je ***** % chlapců.','16.2 Dívky dosáhly v matematice v průměru o ***** procentních bodů horší výsledek než chlapci.','16.3 Tři nejúspěšnější ze všech 14 uchazečů dosáhli v češtině v průměru ***** bodů.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 320" font-family="sans-serif"> <text x="130" y="20" font-size="15" text-anchor="middle" font-weight="bold">DÍVKY</text> <text x="390" y="20" font-size="15" text-anchor="middle" font-weight="bold">CHLAPCI</text> <text x="15" y="45" font-size="13" font-weight="bold">jméno</text> <text x="150" y="45" font-size="13" font-weight="bold">čeština</text> <text x="215" y="45" font-size="13" font-weight="bold">matem.</text> <text x="275" y="45" font-size="13" font-weight="bold">jméno</text> <text x="410" y="45" font-size="13" font-weight="bold">čeština</text> <text x="475" y="45" font-size="13" font-weight="bold">matem.</text> <line x1="10" y1="52" x2="255" y2="52" stroke="#000" stroke-width="1"/> <line x1="270" y1="52" x2="515" y2="52" stroke="#000" stroke-width="1"/> <text x="15" y="75" font-size="13">Adéla</text><text x="175" y="75" font-size="13" text-anchor="middle">44</text><text x="238" y="75" font-size="13" text-anchor="middle">46</text> <text x="15" y="100" font-size="13">Lucie</text><text x="175" y="100" font-size="13" text-anchor="middle">50</text><text x="238" y="100" font-size="13" text-anchor="middle">38</text> <text x="15" y="125" font-size="13">Jolana</text><text x="175" y="125" font-size="13" text-anchor="middle">41</text><text x="238" y="125" font-size="13" text-anchor="middle">45</text> <text x="15" y="150" font-size="13">Marie</text><text x="175" y="150" font-size="13" text-anchor="middle">40</text><text x="238" y="150" font-size="13" text-anchor="middle">44</text> <text x="15" y="175" font-size="13">Petra</text><text x="175" y="175" font-size="13" text-anchor="middle">40</text><text x="238" y="175" font-size="13" text-anchor="middle">35</text> <text x="15" y="200" font-size="13">Eva</text><text x="175" y="200" font-size="13" text-anchor="middle">46</text><text x="238" y="200" font-size="13" text-anchor="middle">28</text> <text x="15" y="225" font-size="13">Radka</text><text x="175" y="225" font-size="13" text-anchor="middle">40</text><text x="238" y="225" font-size="13" text-anchor="middle">30</text> <text x="275" y="75" font-size="13">Ondřej</text><text x="435" y="75" font-size="13" text-anchor="middle">44</text><text x="498" y="75" font-size="13" text-anchor="middle">47</text> <text x="275" y="100" font-size="13">Petr</text><text x="435" y="100" font-size="13" text-anchor="middle">42</text><text x="498" y="100" font-size="13" text-anchor="middle">45</text> <text x="275" y="125" font-size="13">Ivo</text><text x="435" y="125" font-size="13" text-anchor="middle">45</text><text x="498" y="125" font-size="13" text-anchor="middle">40</text> <text x="275" y="150" font-size="13">Jarda</text><text x="435" y="150" font-size="13" text-anchor="middle">38</text><text x="498" y="150" font-size="13" text-anchor="middle">44</text> <text x="275" y="175" font-size="13">Pavel</text><text x="435" y="175" font-size="13" text-anchor="middle">39</text><text x="498" y="175" font-size="13" text-anchor="middle">43</text> <text x="275" y="200" font-size="13">Vítek</text><text x="435" y="200" font-size="13" text-anchor="middle">42</text><text x="498" y="200" font-size="13" text-anchor="middle">36</text> <text x="275" y="225" font-size="13">Honza</text><text x="435" y="225" font-size="13" text-anchor="middle">30</text><text x="498" y="225" font-size="13" text-anchor="middle">39</text> <text x="15" y="255" font-size="12" fill="#555">V každém testu bylo možné získat nejvýše 50 bodů.</text> </svg>',
  'grafy-prijimacky.svg',
  'Body z češtiny a matematiky sedmi dívek a sedmi chlapců; nejvýše 50 bodů za test.',
  'Výsledky testů dívek a chlapců (čeština, matematika)',
  new List<String>{'Celkové součty (čeština + matematika): dívky – Adéla $90$, Lucie $88$, Jolana $86$, Marie $84$, Petra $75$, Eva $74$, Radka $70$; chlapci – Ondřej $91$, Petr $87$, Ivo $85$, Jarda $82$, Pavel $82$, Vítek $78$, Honza $69$.','16.1 Mezi deseti nejúspěšnějšími je 6 chlapců a 4 dívky, tj. $\\dfrac{6}{10} = 60\\,\\%$ chlapců.','16.2 Průměr matematiky dívek $= \\dfrac{46+38+45+44+35+28+30}{7} = 38$ bodů, chlapců $= \\dfrac{47+45+40+44+43+36+39}{7} = 42$ bodů. Rozdíl $4$ body z $50$ možných je $8$ procentních bodů.','16.3 Tři nejúspěšnější celkově: Ondřej ($91$), Adéla ($90$), Lucie ($88$); jejich body z češtiny $44$, $44$, $50$, průměr $\\dfrac{44+44+50}{3} = 46$ bodů.'},
  '16.1: $60\\,\\%$; 16.2: $8$; 16.3: $46$ bodů',
  6, 9, '4',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
