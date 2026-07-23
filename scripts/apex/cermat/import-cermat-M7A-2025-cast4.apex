String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD25C0T01';
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
  'CERMAT M7A 2025 - uloha 10',
  new List<String>{'Standardni hraci kostka tvaru krychle ma na svych stenach 1 az 6 tecek; soucet tecek na protejsich stenach je vzdy 7. Na obrazku jsou tri takove kostky a kazda stoji na zacatku cesty slozene z nekolika ctvercovych poli. Kostka postupne projde vsemi poli cesty tak, ze se vzdy preklopi kolem sve spodni hrany na sousedni pole, a skonci na sedem poli cesty. (Napriklad prvni kostka se preklopi celkem ctyrikrat; po prvnim preklopeni bude mit na spodni stene 5 tecek.)','Kazda z kostek prosla celou svou cestu a nyni stoji na sedem poli. Rozhodnete o kazdem z tvrzeni 10.1-10.3, zda je pravdive (A), ci nikoli (N).','10.1 Prvni kostka ma na spodni stene 3 tecky.','10.2 Druha kostka ma na spodni stene nejmene tecek ze vsech tri kostek.','10.3 Treti kostka ma na spodni stene o 1 tecku mene nez prvni kostka.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 120" font-family="sans-serif"> <text x="280" y="52" font-size="13" text-anchor="middle">Tri hraci kostky se preklapeji po ctvercovych polich az na sede pole (viz testovy sesit).</text> <text x="280" y="82" font-size="11" text-anchor="middle" fill="#666">Prostorove preklapeni kostek nelze verne prenest do SVG; posuzuje se podle originalu.</text> </svg>',
  'kostky.svg',
  'Tri hraci kostky na zacatku cest z ctvercovych poli (schematicka poznamka).',
  'Prostorova uloha - viz testovy sesit',
  new List<String>{'Postupnym preklapenim kazde kostky podle obrazku urcime pocet tecek na jeji spodni stene v cili.','10.1 Prvni kostka nema na spodni stene 3 tecky, tvrzeni je Ne.','10.2 Druha kostka ma na spodni stene nejmene tecek ze vsech tri kostek, tvrzeni je Ano.','10.3 Treti kostka nema na spodni stene o 1 tecku mene nez prvni, tvrzeni je Ne.'},
  '10.1: Ne; 10.2: Ano; 10.3: Ne',
  4, 6, '4',
  new List<String>{'zs2','r7','stereometrie','porozumeni','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2025 - uloha 11',
  new List<String>{'Vesnici se prohnalo tornado. Po udalosti bylo 40 % vsech domu ve vesnici poskozenych. Zbylych 270 domu vyvazlo beze skod. Nasledne bylo 30 % poskozenych domu urceno k demolici.','Kolik poskozenych domu bylo urceno k demolici?'},
  new List<String>{'A) 36 domu','B) 54 domu','C) 60 domu','D) 81 domu','E) jiny pocet domu'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Beze skod zustalo 60 % domu, tj. 270 domu; celkem $270:0{,}6=450$ domu. Poskozenych bylo 40 % ze 450, tj. 180. K demolici bylo urceno 30 % ze 180, tj. $0{,}3\\cdot 180=54$ domu.'},
  'B) 54 domu',
  2, 3, '2',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2025 - uloha 12',
  new List<String>{'Tibor a Matyas jsou na tabore v rovinate oblasti a chystaji se vydat podle mapy ke studance. Tibor ma mapu s meritkem 1 : 50 000 a planovana trasa ma na jeho mape delku 4,2 cm. Na Matyasove mape tato trasa meri 28 mm.','Jake meritko ma Matyasova mapa?'},
  new List<String>{'A) 1 : 28 000','B) 1 : 56 000','C) 1 : 75 000','D) 1 : 140 000','E) jine meritko'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Skutecna delka trasy: $4{,}2$ cm $\\cdot 50\\,000=210\\,000$ cm $=2{,}1$ km. Na Matyasove mape $28$ mm $=2{,}8$ cm odpovida $210\\,000$ cm, meritko je $210\\,000:2{,}8=75\\,000$, tj. 1 : 75 000.'},
  'C) 1 : 75 000',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2025 - uloha 13',
  new List<String>{'Tibor a Matyas jsou na tabore v rovinate oblasti a chystaji se vydat podle mapy ke studance. Tibor ma mapu s meritkem 1 : 50 000 a planovana trasa ma na jeho mape delku 4,2 cm. Na Matyasove mape tato trasa meri 28 mm.','Jaka je skutecna delka planovane trasy?'},
  new List<String>{'A) 2,1 km','B) 2,8 km','C) 5,6 km','D) 7,5 km','E) jina delka'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Skutecna delka $=4{,}2$ cm $\\cdot 50\\,000=210\\,000$ cm $=2{,}1$ km.'},
  'A) 2,1 km',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
