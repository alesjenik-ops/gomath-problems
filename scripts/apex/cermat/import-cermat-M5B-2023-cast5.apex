String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD23C0T02';
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
  'CERMAT M5B 2023 – úloha 10',
  new List<String>{'Sára, Lukáš, Dan a Adéla hráli hru, ve které získávali body. Sára získala stejný počet bodů jako Lukáš. Dan získal 60 bodů, což je o polovinu bodů více, než získali Sára a Lukáš dohromady, ale o čtvrtinu bodů méně, než získala Adéla.','Který z grafů zobrazuje odpovídající počty bodů získaných ve hře?'},
  new List<String>{'A) Sára a Lukáš po 30, Dan 60, Adéla přes 60','B) Sára a Lukáš po 10, Dan 60, Adéla 45','C) Sára a Lukáš po 10, Dan 60, Adéla přes 60','D) Sára a Lukáš po 20, Dan 60, Adéla 80','E) Sára a Lukáš po 20, Dan 60, Adéla 45'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Dan má $60$ bodů. $60$ je o polovinu více než součet bodů Sáry a Lukáše: $60=\\frac{3}{2}(S+L)$, tedy $S+L=40$, a protože $S=L$, je $S=L=20$. $60$ je o čtvrtinu méně než body Adély: $60=\\frac{3}{4}A$, tedy $A=80$. Hledaný graf: Sára $20$, Lukáš $20$, Dan $60$, Adéla $80$ — graf D.'},
  'D) Sára a Lukáš po 20, Dan 60, Adéla 80',
  2, 4, '3',
  new List<String>{'zs1','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2023 – úloha 11',
  new List<String>{'Na dřevěné krychli bylo vyznačeno pět úseček. Čtyři z nich jsou označeny písmeny $a$, $b$, $c$, $d$; u páté úsečky je zapsána její skutečná délka $8$ cm (viz obrázek). Skutečné délky úseček na krychli můžeme vzájemně porovnat.','Které z následujících tvrzení je chybné?'},
  new List<String>{'A) Úsečka $a$ je stejně dlouhá jako úsečka $c$.','B) Úsečka $b$ je stejně dlouhá jako úsečka $d$.','C) Úsečka $b$ měří $8$ cm.','D) Úsečka $c$ je kratší než $8$ cm.','E) Úsečka $d$ je delší než $8$ cm.'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 230" font-family="sans-serif"> <g fill="none" stroke="#999" stroke-width="1.2"> <rect x="70" y="80" width="120" height="120"/> <line x1="70" y1="80" x2="125" y2="42"/> <line x1="190" y1="80" x2="245" y2="42"/> <line x1="190" y1="200" x2="245" y2="162"/> <line x1="70" y1="200" x2="125" y2="162"/> <line x1="125" y1="42" x2="245" y2="42"/> <line x1="245" y1="42" x2="245" y2="162"/> <line x1="125" y1="42" x2="125" y2="162"/> <line x1="125" y1="162" x2="245" y2="162"/> </g> <g fill="none" stroke="#000" stroke-width="2"> <line x1="70" y1="80" x2="190" y2="200"/> <line x1="70" y1="80" x2="245" y2="42"/> <line x1="190" y1="80" x2="245" y2="162"/> <line x1="70" y1="80" x2="70" y2="200"/> <line x1="70" y1="200" x2="190" y2="200"/> </g> <g font-size="15" font-style="italic" text-anchor="middle"> <text x="58" y="145">c</text> <text x="120" y="160">b</text> <text x="130" y="216">a</text> <text x="165" y="52">d</text> </g> <text x="230" y="118" font-size="13">8 cm</text> </svg>',
  'krychle-usecky.svg',
  'Krychle v náryse s vyznačenými úsečkami a (hrana), b (stěnová úhlopříčka), c (hrana), d (stěnová úhlopříčka) a pátou úsečkou délky 8 cm.',
  'Schematický nákres krychle s vyznačenými úsečkami',
  new List<String>{'Úsečky $b$ a $d$ jsou shodné s pátou úsečkou (jsou to stěnové úhlopříčky krychle), takže $|b|=|d|=8$ cm. Úsečka $d$ proto není delší než $8$ cm — tvrzení E je chybné. Úsečky $a$ a $c$ jsou hrany krychle, jsou navzájem shodné a kratší než $8$ cm, takže tvrzení A, B, C, D jsou pravdivá.'},
  'E) Úsečka $d$ je delší než $8$ cm.',
  2, 3, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2023 – úloha 12',
  new List<String>{'Stavba byla vytvořena ze stejně velkých válců tří různých barev. Stavbu jsme zobrazili při pohledu zepředu a shora (viz testový sešit).','Který z obrázků A–E může představovat pohled na stavbu zprava?'},
  new List<String>{'A) obrázek A','B) obrázek B','C) obrázek C','D) obrázek D','E) obrázek E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 90" font-family="sans-serif"> <text x="280" y="35" font-size="13" text-anchor="middle">Stavba ze stejně velkých válců tří barev – pohled zepředu a shora (viz testový sešit).</text> <text x="280" y="62" font-size="11" text-anchor="middle" fill="#666">Prostorovou stavbu nelze věrně přenést do SVG; posuzuje se podle originálu.</text> </svg>',
  'stavba-valce.svg',
  'Schematická poznámka k prostorové stavbě ze stejně velkých válců tří barev.',
  'Prostorová stavba z válců – viz testový sešit',
  new List<String>{'Porovnáním pohledu zepředu a shora s nabízenými možnostmi (poloha a barvy válců při pohledu zprava) vyhovuje pouze obrázek E.'},
  'E) obrázek E',
  2, 3, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
