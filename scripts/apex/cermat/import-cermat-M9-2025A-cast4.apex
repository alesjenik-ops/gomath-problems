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
  'CERMAT M9A 2025 - uloha 10 (konstrukce)',
  new List<String>{'V rovine lezi bod $B$ a primky $p$, $q$, ktere se protinaji v bode $C$ (viz obrazek). Body $B$, $C$ jsou vrcholy trojuhelniku $ABC$. Na primce $p$ lezi vyska $v_c$ na stranu $c$ a na primce $q$ lezi teznice $t_c$ na stranu $c$ tohoto trojuhelniku.','Sestrojte vrchol $A$ trojuhelniku $ABC$, oznacte ho pismenem a trojuhelnik narysujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif"> <line x1="175" y1="262" x2="268" y2="52" stroke="#000" stroke-width="1.5"/><text x="238" y="60" font-size="15" font-style="italic">p</text> <line x1="292" y1="258" x2="258" y2="48" stroke="#000" stroke-width="1.5"/><text x="272" y="58" font-size="15" font-style="italic">q</text> <text x="268" y="86" font-size="15" font-style="italic">C</text> <text x="356" y="188" font-size="15" text-anchor="middle">x</text> <text x="356" y="204" font-size="15" font-style="italic" text-anchor="middle">B</text> </svg>',
  'bodB-pq.svg',
  'Bod B a dve primky p, q protinajici se v bode C.',
  'Vychozi obrazek k uloze 10',
  new List<String>{'Strana $c=AB$ je kolma k vysce $v_c$, tedy k primce $p$; primku $AB$ proto vedeme bodem $B$ kolmo k $p$. Prusecik primky $AB$ s primkou $q$ (na niz lezi teznice $t_c$) je stred $S$ strany $AB$. Vrchol $A$ je obraz bodu $B$ ve stredove soumernosti se stredem $S$ ($|SA|=|SB|$).'},
  'Primka $AB$ prochazi bodem $B$ kolmo k $p$; jeji prusecik s $q$ je stred $S$ strany $AB$ a vrchol $A$ je obraz $B$ podle stredu $S$ (viz nakres v klici).',
  2, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2025 - uloha 11',
  new List<String>{'Zakladni kvadr ma delky hran $1$ cm, $2$ cm a $3$ cm. Kazde z teles $M$, $N$, $P$, $Q$, $R$ bylo slepeno ze dvou zakladnich kvadrU; telesa $M$, $N$ jsou ctyrboke hranoly (viz testovy sesit).','Rozhodnete o kazdem z nasledujicich tvrzeni (11.1-11.3), zda je pravdive (A), ci nikoli (N).','11.1 Soucet delek vsech hran jednoho zakladniho kvadru je $24$ cm.','11.2 Povrchy hranolU $M$ a $N$ se lisi o $6$ cm2.','11.3 Vsechna tri telesa $P$, $Q$, $R$ maji stejny povrch.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif"> <text x="280" y="42" font-size="13" text-anchor="middle">Zakladni kvadr 1 cm x 2 cm x 3 cm; telesa M, N (ctyrboke hranoly)</text> <text x="280" y="64" font-size="13" text-anchor="middle">a P, Q, R jsou slepena vzdy ze dvou zakladnich kvadru (viz testovy sesit).</text> <text x="280" y="98" font-size="11" text-anchor="middle" fill="#666">Prostorova telesa nelze verne prenest do SVG; posuzuje se podle originalu.</text> </svg>',
  'telesa-kvadry.svg',
  'Zakladni kvadr a telesa M, N, P, Q, R slepena ze dvou kvadrU (schematicka poznamka).',
  'Prostorova telesa - viz testovy sesit',
  new List<String>{'11.1 Kvadr ma soucet delek hran $4\\cdot(1+2+3)=24$ cm. Pravda (A).','11.2 Hranoly slozene ze dvou kvadrU maji povrchy $32$ cm2 a $38$ cm2, lisi se o $6$ cm2. Pravda (A).','11.3 Kazde z teles $P$, $Q$, $R$ vzniklo slepenim dvou kvadrU podel shodne steny; slepena plocha je stejna, proto maji stejny povrch. Pravda (A).'},
  '11.1: Ano; 11.2: Ano; 11.3: Ano',
  4, 7, '3',
  new List<String>{'zs2','r9','stereometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
