String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD24C0T01';
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
  'CERMAT M5A 2024 - uloha 4.3',
  new List<String>{'V utery rano meli v obchode bednu plnou jablek. Dopoledne z jablek v teto bedne prodali jednu petinu a do konce dne jeste $20$ kusu. Pote jim na druhy den v bedne zustaly dve petiny jablek.','Kolik jablek bylo v utery rano v plne bedne?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Celkem $x$ jablek. Prodali $\\frac{1}{5}x$ a dalsich $20$, zbyly $\\frac{2}{5}x$. Tedy $x-\\frac{1}{5}x-20=\\frac{2}{5}x$, odtud $\\frac{2}{5}x=20$ a $x=50$.'},
  '$50$ jablek',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2024 - uloha 5.1',
  new List<String>{'Doplnte do ramecku takove cislo, aby platila rovnost.','$1$ hodina $+$ $20$ minut $=$ ____ sekund'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ hodina $+$ $20$ minut $=80$ minut. Protoze $1$ minuta $=60$ sekund, je to $80\\cdot 60=4800$ sekund.'},
  '$4800$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2024 - uloha 5.2',
  new List<String>{'Doplnte do ramecku takove cislo, aby platila rovnost.','$\\frac{1}{2}$ metru $+$ ____ milimetru $=$ $1$ metr $-$ $26$ centimetru'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Prava strana: $1$ m $-$ $26$ cm $=100$ cm $-$ $26$ cm $=74$ cm $=740$ mm. Vlevo $\\frac{1}{2}$ m $=500$ mm. Doplnime $740-500=240$ mm.'},
  '$240$',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2024 - uloha 6',
  new List<String>{'Na ciselne ose je vyznaceno $12$ shodnych useku, cisla $44$ a $110$ a neznama cisla $X$ a $Y$ (viz obrazek).','6.1 Urcete neznama cisla $X$ a $Y$.','6.2 Na ciselne ose vyznacte nulu.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 150" font-family="sans-serif"><line x1="30" y1="80" x2="530" y2="80" stroke="#000" stroke-width="1.5"/><line x1="40" y1="69" x2="40" y2="91" stroke="#000" stroke-width="1.5"/><line x1="80" y1="69" x2="80" y2="91" stroke="#000" stroke-width="1.5"/><line x1="120" y1="69" x2="120" y2="91" stroke="#000" stroke-width="1.5"/><line x1="160" y1="69" x2="160" y2="91" stroke="#000" stroke-width="1.5"/><line x1="200" y1="69" x2="200" y2="91" stroke="#000" stroke-width="1.5"/><line x1="240" y1="69" x2="240" y2="91" stroke="#000" stroke-width="1.5"/><line x1="280" y1="69" x2="280" y2="91" stroke="#000" stroke-width="1.5"/><line x1="320" y1="69" x2="320" y2="91" stroke="#000" stroke-width="1.5"/><line x1="360" y1="69" x2="360" y2="91" stroke="#000" stroke-width="1.5"/><line x1="400" y1="69" x2="400" y2="91" stroke="#000" stroke-width="1.5"/><line x1="440" y1="69" x2="440" y2="91" stroke="#000" stroke-width="1.5"/><line x1="480" y1="69" x2="480" y2="91" stroke="#000" stroke-width="1.5"/><line x1="520" y1="69" x2="520" y2="91" stroke="#000" stroke-width="1.5"/><text x="120" y="114" font-size="16" text-anchor="middle">X</text><text x="200" y="114" font-size="16" text-anchor="middle">44</text><text x="320" y="114" font-size="16" text-anchor="middle">Y</text><text x="440" y="114" font-size="16" text-anchor="middle">110</text></svg>',
  'ciselna-osa.svg',
  'Ciselna osa s 12 shodnymi useky; vyznacena jsou cisla X, 44, Y a 110.',
  'Ciselna osa (schematicky nakres)',
  new List<String>{'Mezi cisly $44$ a $110$ lezi $6$ useku, jeden usek odpovida $(110-44):6=11$. $X$ lezi o $2$ useky vlevo od $44$: $X=44-2\\cdot 11=22$. $Y$ lezi o $3$ useky vpravo od $44$: $Y=44+3\\cdot 11=77$.','6.2 Nula je o $2$ useky vlevo od cisla $X=22$, tj. na levem krajnim dilku osy ($22-2\\cdot 11=0$).'},
  '6.1: $X=22$, $Y=77$; 6.2: nula lezi o dva useky vlevo od $X$ (na levem konci osy)',
  4, 4, '3',
  new List<String>{'zs1','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
