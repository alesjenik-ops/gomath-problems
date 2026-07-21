String SRC   = 'CERMAT – Ilustrační test 2020, matematika 9 (čtyřleté obory)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2020 M9I · úloha 14',
  new List<String>{'Školu navštěvuje $400$ žáků. Každý žák školy se učí anglicky nebo německy, někteří studují dokonce oba jazyky. Anglicky se učí $72\\ \\%$ žáků školy. Třetina žáků, kteří se učí anglicky, se učí také německy.','Kolik žáků školy se učí německy?'},
  new List<String>{'A) $96$','B) $112$','C) $180$','D) $198$','E) $208$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Anglicky se učí $0{,}72\\cdot400=288$ žáků; z nich se oba jazyky učí $\\frac{288}{3}=96$ žáků.','Pouze anglicky se učí $288-96=192$ žáků, takže německy (včetně těch, kdo se učí oba jazyky) se učí $400-192=208$ žáků.'},
  'E) $208$',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','uvazovani','vyber','bez-kalkulacky','bezny-zivot'},
  'M9PID20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9I · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Ze všech $420$ hotelových pokojů bylo včera $15\\ \\%$ pokojů obsazených. Dnes je obsazených pokojů o dvě třetiny více než včera. Kolik hotelových pokojů je dnes obsazených?','15.2 Filip má startovní číslo, jehož třetina je o $9$ větší než jeho čtvrtina. Jaké startovní číslo má Filip?','15.3 V krabičce bylo $96$ matiček. Pak jsme z krabičky odebrali šestinu matiček a přidali do ní šroubky. Nyní je v krabičce o $50\\ \\%$ více šroubků než matiček. Kolik šroubků je nyní v krabičce?','Nabídka: A) $96$; B) $105$; C) $108$; D) $115$; E) $120$; F) jiný výsledek.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: včera $0{,}15\\cdot420=63$ pokojů; dnes $63+\\frac{2}{3}\\cdot63=63+42=105$ — \\textbf{B}.','15.2: $\\frac{x}{3}=\\frac{x}{4}+9\\Rightarrow\\frac{x}{12}=9\\Rightarrow x=108$ — \\textbf{C}.','15.3: po odebrání šestiny zůstalo $96-\\frac{96}{6}=96-16=80$ matiček; šroubků je $1{,}5\\cdot80=120$ — \\textbf{E}.'},
  '15.1: B; 15.2: C; 15.3: E',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','rovnice','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PID20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
