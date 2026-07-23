String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M7A 2020 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Farmář z loňské úrody obilí $20\\,\\%$ uskladnil a zbývajících $200$ tun prodal. Kolik tun činila loňská úroda obilí?','15.2 Farmář letos koupil $300$ tun krmiva, což je o $25\\,\\%$ více, než koupil loni. Kolik tun krmiva koupil loni?','15.3 Farmář z loňské úrody kukuřice prodal $10\\,\\%$ velkoodběrateli a třetinu zbytku maloodběratelům. Zbývajících $270$ tun kukuřice uskladnil. Kolik tun z loňské úrody kukuřice prodal?'},
  new List<String>{'A) $180$ tun','B) $200$ tun','C) $210$ tun','D) $240$ tun','E) $250$ tun','F) jiný počet tun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Prodaných $200$ tun je $80\\,\\%$ úrody: $200:0{,}8=250$ tun → E.','15.2 $300$ tun je $125\\,\\%$ loňského množství: $300:1{,}25=240$ tun → D.','15.3 Velkoodběrateli $10\\,\\%$, ze zbytku ($90\\,\\%$) třetina, tj. $30\\,\\%$, maloodběratelům. Uskladněno $270$ tun $=60\\,\\%$ úrody, tedy úroda $450$ tun. Prodáno $10\\,\\%+30\\,\\%=40\\,\\%$ ze $450=180$ tun → A.'},
  '15.1: E ($250$ tun); 15.2: D ($240$ tun); 15.3: A ($180$ tun)',
  6, 9, '4',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2020 – úloha 16',
  new List<String>{'Všechny obrazce sestavené ze sirek splňují pravidla: každý obrazec začíná a končí trojúhelníkem; v prvním obrazci je jeden čtverec a v každém následujícím obrazci přibude další čtverec; uvnitř každého druhého čtverce je jedna sirka. Tedy 1. obrazec je sestaven z $8$ sirek, 2. obrazec z $12$ sirek atd.','Určete,','16.1 o kolik sirek má 7. obrazec více než 4. obrazec,','16.2 z kolika sirek je sestaven 20. obrazec,','16.3 kolikátý obrazec je sestaven ze $148$ sirek.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 170" font-family="sans-serif"><text x="83.0" y="32" font-size="12" text-anchor="middle">1. obrazec</text><polygon points="70,40 52,53 70,66" fill="none" stroke="#000" stroke-width="1.5"/><rect x="70" y="40" width="26" height="26" fill="none" stroke="#000" stroke-width="1.5"/><polygon points="96,40 114,53 96,66" fill="none" stroke="#000" stroke-width="1.5"/><text x="256.0" y="32" font-size="12" text-anchor="middle">2. obrazec</text><polygon points="230,40 212,53 230,66" fill="none" stroke="#000" stroke-width="1.5"/><rect x="230" y="40" width="26" height="26" fill="none" stroke="#000" stroke-width="1.5"/><rect x="256" y="40" width="26" height="26" fill="none" stroke="#000" stroke-width="1.5"/><line x1="256" y1="40" x2="282" y2="66" stroke="#000" stroke-width="1.5"/><polygon points="282,40 300,53 282,66" fill="none" stroke="#000" stroke-width="1.5"/><text x="439.0" y="32" font-size="12" text-anchor="middle">3. obrazec</text><polygon points="400,40 382,53 400,66" fill="none" stroke="#000" stroke-width="1.5"/><rect x="400" y="40" width="26" height="26" fill="none" stroke="#000" stroke-width="1.5"/><rect x="426" y="40" width="26" height="26" fill="none" stroke="#000" stroke-width="1.5"/><line x1="426" y1="40" x2="452" y2="66" stroke="#000" stroke-width="1.5"/><rect x="452" y="40" width="26" height="26" fill="none" stroke="#000" stroke-width="1.5"/><polygon points="478,40 496,53 478,66" fill="none" stroke="#000" stroke-width="1.5"/><text x="70" y="150" font-size="11" fill="#555">Uvnitř každého druhého čtverce je jedna sirka.</text></svg>',
  'sirky-obrazce.svg',
  'Obrazce ze sirek: vlevo a vpravo trojúhelník, uprostřed řada čtverců; v každém druhém čtverci úhlopříčná sirka. Zobrazen 1., 2. a 3. obrazec.',
  '1., 2. a 3. obrazec ze sirek',
  new List<String>{'Počet sirek $n$-tého obrazce: obvod řady $n$ čtverců a dvou koncových trojúhelníků dá $3n+5$ sirek a uvnitř přibude $\\left\\lfloor\\frac{n}{2}\\right\\rfloor$ sirek. Celkem $S(n)=3n+5+\\left\\lfloor\\frac{n}{2}\\right\\rfloor$ (kontrola: $S(1)=8$, $S(2)=12$).','16.1 $S(7)=21+5+3=29$, $S(4)=12+5+2=19$; rozdíl $29-19=10$ sirek.','16.2 $S(20)=60+5+10=75$ sirek.','16.3 Pro liché $n$ je $S(n)=\\frac{7n+9}{2}=148\\Rightarrow 7n=287\\Rightarrow n=41$. Ze $148$ sirek je sestaven 41. obrazec.'},
  '16.1: o $10$ sirek; 16.2: $75$ sirek; 16.3: 41. obrazec',
  4, 7, '3',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
