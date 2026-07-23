String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD23C0T01';
Integer YEAR = 2023;

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
  'CERMAT M7A 2023 - uloha 6',
  new List<String>{'Na odmeny pro tri nejlepsi soutezici byla pripravena financni castka v korunach. Prvni soutezici ziskal polovinu teto castky. Druhy soutezici dostal 300 korun. Treti soutezici ziskal zbytek pripravene castky, coz bylo trikrat mene korun, nez ziskal prvni soutezici.','6.1 Vypoctete, kolikrat vice korun dostal druhy soutezici nez treti soutezici.','6.2 Vypoctete, kolik korun bylo celkem pripraveno na odmeny.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Oznacme celkem pripravenou castku $c$. Prvni ziskal $\\frac{c}{2}$; treti ziskal trikrat mene nez prvni, tedy $\\frac{c}{6}$. Treti dostal zbytek: $c-\\frac{c}{2}-300=\\frac{c}{6}$, tj. $\\frac{c}{2}-\\frac{c}{6}=300$, $\\frac{c}{3}=300$, $c=900$.','6.2 Celkem bylo pripraveno $900$ korun.','6.1 Druhy dostal $300$ korun, treti $\\frac{900}{6}=150$ korun; $300:150=2$, tedy dvakrat vice.'},
  '6.1: $2$krat vice; 6.2: $900$ korun',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M7A 2023 - uloha 7',
  new List<String>{'Ze 60 drevenych krychlicek o hrane delky 1 cm jsme slepili kvadr s rozmery 5 cm, 4 cm a 3 cm. Pote jsme cely povrch kvadru obarvili - obe steny s nejvetsim obsahem na bilo a zbyvajici ctyri steny na sedo. Slepene steny krychlicek zustaly neobarveny.','Urcete, kolik ze vsech 60 krychlicek kvadru:','7.1 ma sede obarvene prave dve steny,','7.2 nema zadnou sede obarvenou stenu,','7.3 ma obarvene prave dve steny.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 300" font-family="sans-serif"><polygon points="60,148 230,148 294,104 124,104" fill="#ffffff" stroke="#000"/><polygon points="230,148 294,104 294,206 230,250" fill="#b3b3b3" stroke="#000"/><polygon points="60,148 230,148 230,250 60,250" fill="#cccccc" stroke="#000"/><line x1="94" y1="148" x2="94" y2="250" stroke="#000" stroke-width="0.6"/><line x1="128" y1="148" x2="128" y2="250" stroke="#000" stroke-width="0.6"/><line x1="162" y1="148" x2="162" y2="250" stroke="#000" stroke-width="0.6"/><line x1="196" y1="148" x2="196" y2="250" stroke="#000" stroke-width="0.6"/><line x1="60" y1="216" x2="230" y2="216" stroke="#000" stroke-width="0.6"/><line x1="60" y1="182" x2="230" y2="182" stroke="#000" stroke-width="0.6"/><text x="145" y="272" font-size="14" text-anchor="middle">5 cm</text><text x="42" y="199" font-size="14" text-anchor="middle">3 cm</text><text x="268" y="122" font-size="14">4 cm</text></svg>',
  'kvadr.svg',
  'Schematicky nakres kvadru slepeneho z krychlicek o rozmerech 5 krat 4 krat 3; dve nejvetsi steny jsou bile, ctyri bocni steny sede.',
  'Schematicky nakres kvadru 5x4x3 (bile jsou dve nejvetsi steny)',
  new List<String>{'Bile jsou dve nejvetsi steny $5\\times 4$ (nahore a dole), sede jsou ctyri bocni steny.','7.1 Sede obarvene prave dve steny maji krychlicky na svislych hranach kvadru: $4$ hrany po $3$ krychlickach, tj. $4\\cdot 3=12$ krychlicek.','7.2 Zadnou sedou stenu nemaji vnitrni sloupce ($3\\cdot 2=6$ v kazde vrstve), ve trech vrstvach $6\\cdot 3=18$ krychlicek.','7.3 Prave dve obarvene steny (jakekoli barvy) maji krychlicky na hranach kvadru mimo rohy: $4\\cdot((5-2)+(4-2)+(3-2))=4\\cdot 6=24$ krychlicek.'},
  '7.1: $12$ krychlicek; 7.2: $18$ krychlicek; 7.3: $24$ krychlicek',
  3, 6, '3',
  new List<String>{'zs2','r7','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
