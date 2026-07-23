String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD24C0T02';
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
  'CERMAT M9B 2024 - uloha 10 (konstrukce)',
  new List<String>{'V rovine je dana kruznice $k$ se stredem $S$ a body $K$, $L$. Body $K$, $L$ jsou vrcholy rovnoramenneho trojuhelniku $KLM$ se zakladnou $LM$.','Sestrojte rovnoramenny trojuhelnik $KLM$, lezi-li bod $M$ na kruznici $k$. Naleznete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 320" font-family="sans-serif"> <rect x="4" y="4" width="372" height="312" fill="none" stroke="#bbb"/> <circle cx="200" cy="140" r="110" fill="none" stroke="#000" stroke-width="2"/> <text x="118" y="78" font-size="15" font-style="italic">k</text> <text x="200" y="144" font-size="16">+</text> <text x="214" y="138" font-size="15" font-style="italic">S</text> <text x="88" y="230" font-size="15" font-style="italic">K</text> <text x="104" y="232" font-size="15">x</text> <text x="248" y="288" font-size="15">x</text> <text x="262" y="290" font-size="15" font-style="italic">L</text> </svg>',
  'kruznice-k-kl.svg',
  'Kruznice k se stredem S a dva dane body K vlevo dole a L vpravo dole vne kruznice.',
  'Vychozi obrazek k uloze 10',
  new List<String>{'Ramena rovnoramenneho trojuhelniku jsou $KL$ a $KM$, proto $|KM|=|KL|$. Sestrojime kruznici $m$ se stredem $K$ a polomerem $|KL|$. Jeji pruseciky s danou kruznici $k$ jsou body $M_1$ a $M_2$. Dostavame dve reseni: trojuhelniky $KLM_1$ a $KLM_2$.'},
  'Dve reseni: bod $M$ je prusecik kruznice $k$ s kruznici $(K; |KL|)$ (body $M_1$, $M_2$) - trojuhelniky $KLM_1$ a $KLM_2$ (viz nakres v klici).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2024 - uloha 11',
  new List<String>{'Hracka stala $250$ korun. Nejdrive byla zdrazena o $40\\,\\%$ oproti puvodni cene, po mesici pak byla zlevnena o $40\\,\\%$ z nove ceny.','Kolik stala hracka po teto dvoji uprave cen?'},
  new List<String>{'A) $200$ Kc','B) $210$ Kc','C) $230$ Kc','D) $250$ Kc','E) $280$ Kc'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Po zdrazeni: $250\\cdot 1{,}4=350$ Kc. Po zlevneni o $40\\,\\%$ z nove ceny: $350\\cdot 0{,}6=210$ Kc.'},
  'B) $210$ Kc',
  2, 3, '2',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9B 2024 - uloha 12',
  new List<String>{'Pekar na trhu prodaval male a velke kolacky. Velky kolacek byl o polovinu drazsi nez maly kolacek a stal $30$ Kc. Velke kolacky prodal pekar vsechny a utrzil za ne $3\\,000$ Kc. Desetinu malych kolacku neprodal a za prodane male kolacky utrzil $3\\,600$ Kc.','Kolik pekar puvodne privezl na trh malych kolacku?'},
  new List<String>{'A) $100$','B) $180$','C) $200$','D) $240$','E) jiny pocet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Velky kolacek je o polovinu drazsi nez maly a stoji $30$ Kc, tedy maly stoji $20$ Kc. Za prodane male kolacky pekar utrzil $3\\,600$ Kc, tj. $3\\,600:20=180$ prodanych malych kolacku. To je $\\frac{9}{10}$ vsech (desetinu neprodal), takze puvodne privezl $180:\\frac{9}{10}=200$ malych kolacku.'},
  'C) $200$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
