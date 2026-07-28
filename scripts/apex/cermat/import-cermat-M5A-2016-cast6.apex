String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M5A 2016 – úloha 14',
  new List<String>{'Lukáš si postavil z kostek pravidelnou dvoupatrovou stavbu. Ema si v rohu místnosti postavila jen část této stavby (viz obrázek).','Jaký nejmenší počet kostek potřebuje Ema k doplnění své stavby na krychli?'},
  new List<String>{'A) 7','B) 11','C) 16','D) 17','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 260" font-family="sans-serif"><g fill="#ffffff" stroke="#000" stroke-linejoin="round"><path d="M80 160h26v30h-26z"/><path d="M80 160l9-9h26l-9 9z"/><path d="M106 160h26v30h-26z"/><path d="M106 160l9-9h26l-9 9z"/><path d="M132 160h26v30h-26z"/><path d="M132 160l9-9h26l-9 9z"/><path d="M158 160l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M45 169h26v30h-26z"/><path d="M45 169l9-9h26l-9 9z"/><path d="M71 169h26v30h-26z"/><path d="M71 169l9-9h26l-9 9z"/><path d="M97 169h26v30h-26z"/><path d="M123 169h26v30h-26z"/><path d="M123 169l9-9h26l-9 9z"/><path d="M149 169h26v30h-26z"/><path d="M149 169l9-9h26l-9 9z"/><path d="M175 169l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M97 139h26v30h-26z"/><path d="M97 139l9-9h26l-9 9z"/><path d="M123 139l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M36 178h26v30h-26z"/><path d="M36 178l9-9h26l-9 9z"/><path d="M62 178h26v30h-26z"/><path d="M88 178h26v30h-26z"/><path d="M114 178h26v30h-26z"/><path d="M140 178h26v30h-26z"/><path d="M140 178l9-9h26l-9 9z"/><path d="M166 178l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M62 148h26v30h-26z"/><path d="M62 148l9-9h26l-9 9z"/><path d="M88 148h26v30h-26z"/><path d="M88 148l9-9h26l-9 9z"/><path d="M114 148h26v30h-26z"/><path d="M114 148l9-9h26l-9 9z"/><path d="M140 148l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M27 187h26v30h-26z"/><path d="M27 187l9-9h26l-9 9z"/><path d="M53 187h26v30h-26z"/><path d="M53 187l9-9h26l-9 9z"/><path d="M79 187h26v30h-26z"/><path d="M105 187h26v30h-26z"/><path d="M105 187l9-9h26l-9 9z"/><path d="M131 187h26v30h-26z"/><path d="M131 187l9-9h26l-9 9z"/><path d="M157 187l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M79 157h26v30h-26z"/><path d="M79 157l9-9h26l-9 9z"/><path d="M105 157l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M44 196h26v30h-26z"/><path d="M44 196l9-9h26l-9 9z"/><path d="M70 196h26v30h-26z"/><path d="M70 196l9-9h26l-9 9z"/><path d="M96 196h26v30h-26z"/><path d="M96 196l9-9h26l-9 9z"/><path d="M122 196l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M276 178h26v30h-26z"/><path d="M302 178h26v30h-26z"/><path d="M328 178h26v30h-26z"/><path d="M328 178l9-9h26l-9 9z"/><path d="M354 178l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M276 148h26v30h-26z"/><path d="M276 148l9-9h26l-9 9z"/><path d="M302 148h26v30h-26z"/><path d="M302 148l9-9h26l-9 9z"/><path d="M328 148l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M267 187h26v30h-26z"/><path d="M293 187h26v30h-26z"/><path d="M293 187l9-9h26l-9 9z"/><path d="M319 187h26v30h-26z"/><path d="M319 187l9-9h26l-9 9z"/><path d="M345 187l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M267 157h26v30h-26z"/><path d="M267 157l9-9h26l-9 9z"/><path d="M293 157l9-9v30l-9 9z" fill="#c8c8c8"/><path d="M258 196h26v30h-26z"/><path d="M258 196l9-9h26l-9 9z"/><path d="M284 196h26v30h-26z"/><path d="M284 196l9-9h26l-9 9z"/><path d="M310 196l9-9v30l-9 9z" fill="#c8c8c8"/></g><text x="110" y="240" font-size="14" text-anchor="middle">Lukášova stavba</text><text x="315" y="240" font-size="14" text-anchor="middle">Emina stavba</text></svg>',
  'stavby-z-kostek.svg',
  'Dvě stavby z krychlových kostek: Lukášova dvoupatrová stavba a menší Emina stavba v rohu místnosti.',
  'Schematický nákres obou staveb',
  new List<String>{'Emina stavba má $8$ kostek v dolním patře a $3$ kostky v horním patře, tedy $11$ kostek.','Vejde se do krychle o hraně $3$ kostky, což je nejmenší možná krychle; ta má $3\\cdot 3\\cdot 3=27$ kostek.','Ema tedy potřebuje doplnit $27-11=16$ kostek.'},
  'C) 16',
  2, 4, '4',
  new List<String>{'zs1','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2016 – úloha 15',
  new List<String>{'Adéla přečetla 20 stran knihy, Dana 40 stran a Petr 60 stran.','V nedokončené větě (15.1–15.3) doplňte chybějící část (A–F) tak, aby vzniklo pravdivé tvrzení.','15.1 Adéla přečetla…','15.2 Dana přečetla…','15.3 Petr přečetl…'},
  new List<String>{'A) o polovinu více než Dana.','B) o třetinu více než Dana.','C) o polovinu více než Adéla.','D) o třetinu méně než Petr.','E) pětinu toho, co přečetly zbývající dvě děti dohromady.','F) třetinu toho, co přečetly zbývající dvě děti dohromady.'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Dana a Petr přečetli dohromady $40+60=100$ stran a $20$ je pětina ze $100$ → E.','15.2 Třetina z Petrových $60$ stran je $20$; $60-20=40$ → D.','15.3 Polovina z Daniných $40$ stran je $20$; $40+20=60$ → A.'},
  '15.1: E; 15.2: D; 15.3: A',
  6, 6, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
