String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD24C0T02';
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
  'CERMAT M7B 2024 - uloha 6',
  new List<String>{'Honza, Patrik a David jsou kolegove. Kazdy z nich chodi hrat golf, ale maji ruzne pracovni povinnosti, takze nemohou vzdy hrat spolu. Honza chodi hrat jen kazdy $4.$ den, Patrik jen kazdy $6.$ den a David jen kazdy $5.$ den. Spolecne si zahraji $4.\\,5.\\,2024$. (Kveten ma $31$ dni, cerven $30$ dni.)','6.1 V jaky nejblizsi nasledujici den (uvedte datum) se opet vsichni tri sejdou?','6.2 Kolikrat se mezi dvema setkanimi vsech tri na golfu sesli pouze Honza s Davidem?'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Nejmensi spolecny nasobek cisel $4$, $5$ a $6$ je $60$; vsichni tri se sejdou po $60$ dnech. Od $4.\\,5.$ o $60$ dni: $27$ dni do konce kvetna, dalsich $30$ dni cerven, zbyvaji $3$ dny cervence - tedy $3.\\,7.\\,2024$.','6.2 Honza (kazdy $4.$ den) a David (kazdy $5.$ den) se schazeji po $20$ dnech, tj. $24.\\,5.$ a $13.\\,6.$ (dne $3.\\,7.$ uz je s nimi i Patrik). Pouze Honza s Davidem se tedy sesli dvakrat.'},
  '6.1: $3.\\,7.\\,2024$; 6.2: dvakrat ($24.\\,5.$ a $13.\\,6.$)',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2024 - uloha 7',
  new List<String>{'Ram kolem ctvercoveho zrcadla je tvoren $4$ shodnymi hranoly se ctvercovou podstavou o delce hrany $5$ cm. Kazdy z hranolu je na jednom konci ze tri stran stejnym zpusobem ozdoben. Ozdobena plocha jednoho hranolu (tri ctverce $5$ cm $\\times$ $5$ cm) tvori $6\\,\\%$ povrchu tohoto hranolu.','Jak dlouha je strana viditelne casti ctvercoveho zrcadla umisteneho uvnitr ramu?'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 220" font-family="sans-serif"> <rect x="20" y="20" width="180" height="180" fill="#ededed" stroke="#000" stroke-width="2"/> <rect x="48" y="48" width="124" height="124" fill="#cfe0f0" stroke="#000"/> <text x="110" y="114" font-size="12" text-anchor="middle">zrcadlo</text> <rect x="28" y="28" width="16" height="16" fill="#8f8f8f" stroke="#000"/> <rect x="176" y="28" width="16" height="16" fill="#8f8f8f" stroke="#000"/> <rect x="28" y="176" width="16" height="16" fill="#8f8f8f" stroke="#000"/> <rect x="176" y="176" width="16" height="16" fill="#8f8f8f" stroke="#000"/> <text x="110" y="214" font-size="11" text-anchor="middle">ram se zrcadlem (4 hranoly)</text> <rect x="248" y="30" width="22" height="150" fill="#f4f4f4" stroke="#000"/> <rect x="248" y="30" width="22" height="22" fill="#8f8f8f" stroke="#000"/> <text x="284" y="44" font-size="11">hranol: podstava 5 cm x 5 cm,</text> <text x="284" y="60" font-size="11">ozdoba na 3 stranach = 6 % povrchu</text> <text x="284" y="90" font-size="11">(schematicky nakres)</text> </svg>',
  'ram-zrcadlo.svg',
  'Ctvercovy ram se zrcadlem tvoreny ctyrmi hranoly a schema jednoho hranolu s ozdobou na tri stranach.',
  'Schematicky nakres ramu a hranolu',
  new List<String>{'Ozdobena plocha je $3\\cdot(5\\cdot 5) = 75$ cm2 a tvori $6\\,\\%$ povrchu, takze povrch hranolu je $75:0{,}06 = 1250$ cm2.','Pro delku hranolu $d$ plati $2\\cdot 5\\cdot 5 + 4\\cdot 5\\cdot d = 1250$, tj. $50 + 20d = 1250$, odtud $d = 60$ cm.','V rozich se sousedni hranoly prekryvaji o $5$ cm, proto strana viditelne casti zrcadla je $60 - 5 = 55$ cm.'},
  '$55$ cm',
  3, 7, '4',
  new List<String>{'zs2','r7','stereometrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
