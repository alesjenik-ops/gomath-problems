String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M5B 2019 – úloha 13',
  new List<String>{'Na podložce stavíme různé stavby ze stejných krychliček. Každá krychlička stavby stojí buď na podložce, nebo na jiné krychličce. Stavbu popisujeme dvěma plánky.','Na prvním plánku (shora) jsou v jednotlivých polích uvedeny počty krychliček nad sebou při pohledu shora. Na druhém plánku (zepředu) jsou počty krychliček za sebou při pohledu zepředu. Vlevo je uveden vzor, vpravo jiná stavba, na jejíchž pláncích jsou tři čísla zakryta šedými kartičkami $K$, $L$, $M$.','Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).','13.1 Jaké číslo je zakryté kartičkou $K$?','13.2 Jaké číslo je zakryté kartičkou $L$?','13.3 Jaký je součet čísel zakrytých kartičkami $L$ a $M$?'},
  new List<String>{'A) $0$','B) $1$','C) $2$','D) $3$','E) $4$','F) $5$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 138" font-family="sans-serif"><g stroke="#000" fill="#fff"><rect x="30" y="44" width="26" height="24" fill="#fff"/><rect x="56" y="44" width="26" height="24" fill="#fff"/><rect x="30" y="68" width="26" height="24" fill="#fff"/><rect x="56" y="68" width="26" height="24" fill="#fff"/><rect x="30" y="92" width="26" height="24" fill="#fff"/><rect x="56" y="92" width="26" height="24" fill="#fff"/><rect x="140" y="44" width="26" height="24" fill="#fff"/><rect x="166" y="44" width="26" height="24" fill="#fff"/><rect x="140" y="68" width="26" height="24" fill="#fff"/><rect x="166" y="68" width="26" height="24" fill="#fff"/><rect x="140" y="92" width="26" height="24" fill="#fff"/><rect x="166" y="92" width="26" height="24" fill="#fff"/><rect x="290" y="44" width="26" height="24" fill="#fff"/><rect x="316" y="44" width="26" height="24" fill="#fff"/><rect x="290" y="68" width="26" height="24" fill="#c9c9c9"/><rect x="316" y="68" width="26" height="24" fill="#fff"/><rect x="290" y="92" width="26" height="24" fill="#fff"/><rect x="316" y="92" width="26" height="24" fill="#fff"/><rect x="400" y="44" width="26" height="24" fill="#fff"/><rect x="426" y="44" width="26" height="24" fill="#c9c9c9"/><rect x="400" y="68" width="26" height="24" fill="#fff"/><rect x="426" y="68" width="26" height="24" fill="#fff"/><rect x="400" y="92" width="26" height="24" fill="#fff"/><rect x="426" y="92" width="26" height="24" fill="#c9c9c9"/></g><g font-size="14" text-anchor="middle"><text x="43" y="61">3</text><text x="69" y="61">2</text><text x="43" y="85">1</text><text x="69" y="85">0</text><text x="43" y="109">2</text><text x="69" y="109">1</text><text x="153" y="61">1</text><text x="179" y="61">0</text><text x="153" y="85">2</text><text x="179" y="85">1</text><text x="153" y="109">3</text><text x="179" y="109">2</text><text x="303" y="61">1</text><text x="329" y="61">3</text><text x="303" y="85">K</text><text x="329" y="85">3</text><text x="303" y="109">2</text><text x="329" y="109">1</text><text x="413" y="61">0</text><text x="439" y="61">M</text><text x="413" y="85">2</text><text x="439" y="85">2</text><text x="413" y="109">3</text><text x="439" y="109">L</text></g><g font-size="11"><text x="40" y="38">shora</text><text x="150" y="38">zepředu</text><text x="300" y="38">shora</text><text x="410" y="38">zepředu</text></g><g font-size="12" font-weight="bold"><text x="60" y="16">Vzor</text><text x="300" y="16">Jiná stavba</text></g></svg>',
  'planky-krychlicky.svg',
  'Plánky shora a zepředu: vzorová stavba a jiná stavba se třemi poli zakrytými kartičkami K, L, M.',
  'Plánky stavby (shora a zepředu)',
  new List<String>{'Plánek shora udává výšky sloupců krychliček, plánek zepředu počty krychliček v jednotlivých výškových hladinách při pohledu zepředu. Porovnáním obou plánků vyjde $K = 2$, $L = 3$ a $M = 2$.','13.1 $K = 2$ → C.','13.2 $L = 3$ → D.','13.3 $L + M = 3 + 2 = 5$ → F.'},
  '13.1: C ($2$); 13.2: D ($3$); 13.3: F ($5$)',
  5, 6, '4',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
