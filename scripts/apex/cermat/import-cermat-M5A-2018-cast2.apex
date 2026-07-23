String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M5A 2018 – úloha 4',
  new List<String>{'Aleniny, Bořkovy i Cyrilovy čerstvě nakrájené houby snížily svou hmotnost během první noci o třetinu a po týdnu už měly jen desetinu hmotnosti čerstvě nakrájených hub. Aleniny čerstvě nakrájené houby měly hmotnost $1\\,650$ gramů. Bořkovy nakrájené houby ztratily na váze během první noci $720$ gramů a Cyrilovy houby měly po týdnu hmotnost $210$ gramů.','Vypočtěte, kolik gramů vážily po první noci','4.1 Aleniny houby;','4.2 Bořkovy houby;','4.3 Cyrilovy houby.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Během první noci ubude třetina, zůstanou dvě třetiny: $\\frac{2}{3}\\cdot 1\\,650=1\\,100$ g.','4.2 Ztráta $720$ g je třetina čerstvé hmotnosti, čerstvé houby vážily $3\\cdot 720=2\\,160$ g; po první noci $2\\,160-720=1\\,440$ g.','4.3 Po týdnu $210$ g je desetina čerstvé hmotnosti, čerstvé houby vážily $10\\cdot 210=2\\,100$ g; po první noci $\\frac{2}{3}\\cdot 2\\,100=1\\,400$ g.'},
  '4.1: $1\\,100$ g; 4.2: $1\\,440$ g; 4.3: $1\\,400$ g',
  5, 5, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2018 – úloha 5',
  new List<String>{'Na stole bylo $10$ světlých kuliček a o něco více tmavých kuliček. Ema a Ivo si rozdělili všech $10$ světlých kuliček tak, že Ema si vzala o $4$ kuličky více než Ivo. Ema si pak vzala ještě několik tmavých kuliček a Ivo si jich vzal dvakrát více než Ema. Dohromady obě děti odebraly jen tolik tmavých kuliček, aby měly celkový počet kuliček stejný.','5.1 Vypočtěte, kolik světlých kuliček si vzala Ema.','5.2 Vypočtěte, kolik tmavých kuliček si vzal Ivo.','5.3 Vypočtěte, kolik kuliček si celkem vzala Ema.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 180" font-family="sans-serif"><circle cx="32" cy="35" r="15" fill="#d6d6d6" stroke="#000"/><circle cx="82" cy="35" r="15" fill="#d6d6d6" stroke="#000"/><circle cx="132" cy="35" r="15" fill="#d6d6d6" stroke="#000"/><circle cx="182" cy="35" r="15" fill="#d6d6d6" stroke="#000"/><circle cx="232" cy="35" r="15" fill="#d6d6d6" stroke="#000"/><circle cx="282" cy="35" r="15" fill="#d6d6d6" stroke="#000"/><circle cx="332" cy="35" r="15" fill="#d6d6d6" stroke="#000"/><circle cx="382" cy="35" r="15" fill="#d6d6d6" stroke="#000"/><circle cx="432" cy="35" r="15" fill="#d6d6d6" stroke="#000"/><circle cx="482" cy="35" r="15" fill="#d6d6d6" stroke="#000"/><circle cx="32" cy="90" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="82" cy="90" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="132" cy="90" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="182" cy="90" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="232" cy="90" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="282" cy="90" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="332" cy="90" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="382" cy="90" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="432" cy="90" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="482" cy="90" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="32" cy="145" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="82" cy="145" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="132" cy="145" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="182" cy="145" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="232" cy="145" r="15" fill="#4a4a4a" stroke="#000"/><circle cx="282" cy="145" r="15" fill="#4a4a4a" stroke="#000"/><text x="330" y="153" font-size="22">…</text></svg>',
  'kulicky.svg',
  'Deset světlých kuliček v horní řadě a větší počet tmavých kuliček pod nimi.',
  'schematický nákres',
  new List<String>{'5.1 Světlých je $10$: Ema $+$ Ivo $=10$ a Ema $=$ Ivo $+4$, tedy Ivo $=3$ a Ema $=7$.','5.2 Ema si vzala $t$ tmavých, Ivo $2t$. Stejné celkové počty: $7+t=3+2t$, odtud $t=4$; Ivo má $2t=8$ tmavých.','5.3 Ema si vzala $7$ světlých a $4$ tmavé, celkem $11$ kuliček.'},
  '5.1: $7$; 5.2: $8$; 5.3: $11$',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2018 – úloha 6',
  new List<String>{'Jana si nahrála na několik CD všechny lekce angličtiny, a to postupně od první lekce do poslední. Jednotlivá CD zaplňovala rovněž v pořadí od prvního do posledního CD. Na každém CD je stejný počet lekcí. Lekce číslo $49$ je v pořadí na pátém CD.','Určete, kolik lekcí může být na jednom CD. Uveďte všechna možná řešení.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Je-li na každém CD $n$ lekcí, obsahuje páté CD lekce $4n+1$ až $5n$. Musí platit $4n+1\\le 49\\le 5n$, tedy $n\\le 12$ a $n\\ge 9{,}8$. Vyhovují celá čísla $n=10$, $11$, $12$.'},
  '$10$, $11$ nebo $12$ lekcí',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
