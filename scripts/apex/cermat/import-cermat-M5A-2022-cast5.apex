String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD22C0T01';
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
  'CERMAT M5A 2022 – úloha 8',
  new List<String>{'Ve čtvercové síti jsou zakresleny tři útvary (1., 2. a 3. útvar), jejichž vrcholy leží v mřížových bodech (viz obrázek).','Rozhodněte o každém z útvarů 8.1–8.3, zda je osově souměrný (Ano), či nikoli (Ne).','8.1 1. útvar','8.2 2. útvar','8.3 3. útvar'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 170" font-family="sans-serif"> <rect x="10" y="24" width="540" height="120" fill="none" stroke="#ccc"/> <text x="100" y="18" font-size="12" text-anchor="middle">1. utvar</text> <text x="280" y="18" font-size="12" text-anchor="middle">2. utvar</text> <text x="460" y="18" font-size="12" text-anchor="middle">3. utvar</text> <text x="280" y="86" font-size="12" text-anchor="middle">Tri slozite utvary v mrizove siti (schematicky) - viz testovy sesit.</text> <text x="280" y="110" font-size="11" text-anchor="middle" fill="#666">Osova soumernost se posuzuje podle originalu.</text> </svg>',
  'utvary.svg',
  'Tři složité útvary ve čtvercové síti s vrcholy v mřížových bodech (schematická poznámka).',
  'schematický nákres',
  new List<String>{'8.1 První útvar má osu souměrnosti, je osově souměrný → Ano.','8.2 Druhý útvar žádnou osu souměrnosti nemá → Ne.','8.3 Třetí útvar žádnou osu souměrnosti nemá → Ne.'},
  '8.1: Ano; 8.2: Ne; 8.3: Ne',
  4, 5, '3',
  new List<String>{'zs1','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2022 – úloha 9',
  new List<String>{'Petr šel z domova do sportovní haly. Každou pětinu cesty ušel za stejnou dobu. Když ušel první pětinu cesty od domova, jeho hodinky ukazovaly čas 14:54. Když mu k hale zbývala ještě pětina cesty, ukazovaly hodinky čas 15:12.','Jaký čas ukazovaly Petrovy hodinky, když vycházel z domova?'},
  new List<String>{'A) méně než 14:35','B) 14:35','C) 14:42','D) 14:48','E) více než 14:48'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Od konce první pětiny (14:54) do začátku poslední (páté) pětiny (15:12) uplynulo $18$ minut a Petr ušel tři pětiny cesty. Jedna pětina trvá $18:3=6$ minut. Z domova vyšel o $6$ minut dříve než ve 14:54, tedy ve 14:48.'},
  'D) 14:48',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2022 – úloha 10',
  new List<String>{'Všechny děti z oddílu se rozdělily do čtyřčlenných hlídek. V každé hlídce byla jediná dívka. V oddílu je celkem 36 chlapců.','Kolik dětí je v oddílu?'},
  new List<String>{'A) 48 dětí','B) 45 dětí','C) 42 dětí','D) 40 dětí','E) jiný počet dětí'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'V každé čtyřčlenné hlídce je $1$ dívka a $3$ chlapci. Počet hlídek $=36:3=12$. Dětí celkem $=12\\cdot 4=48$.'},
  'A) 48 dětí',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2022 – úloha 11',
  new List<String>{'Na Dračí horu přiletěli dvouhlaví a tříhlaví draci. Dohromady měli 115 hlav. Dvouhlavých draků přiletělo o 35 více než tříhlavých.','Kolik draků přiletělo na Dračí horu?'},
  new List<String>{'A) 53 draků','B) 50 draků','C) 44 draků','D) 40 draků','E) jiný počet draků'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť tříhlavých draků je $t$, dvouhlavých $t+35$. Počet hlav: $2(t+35)+3t=115$, tj. $5t+70=115$, odtud $t=9$. Draků celkem $=9+(9+35)=9+44=53$.'},
  'A) 53 draků',
  2, 3, '2',
  new List<String>{'zs1','rovnice','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2022 – úloha 12',
  new List<String>{'Na stadionu se konalo hromadné vystoupení dětí. Cvičil stejný počet děvčat i chlapců. Na začátku vystoupení všechna děvčata vytvořila devítičlenné skupiny a všichni chlapci šestičlenné skupiny. Děvčata vytvořila o 30 skupin méně než chlapci.','Kolik skupin vytvořily na začátku vystoupení všechny děti?'},
  new List<String>{'A) méně než 70 skupin','B) 70 skupin','C) 90 skupin','D) 150 skupin','E) více než 150 skupin'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Počet děvčat i chlapců označme $n$. Skupin děvčat je $\\frac{n}{9}$, skupin chlapců $\\frac{n}{6}$. Platí $\\frac{n}{6}-\\frac{n}{9}=30$, tj. $\\frac{n}{18}=30$, odtud $n=540$. Skupin celkem $=\\frac{540}{9}+\\frac{540}{6}=60+90=150$.'},
  'D) 150 skupin',
  2, 4, '3',
  new List<String>{'zs1','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
