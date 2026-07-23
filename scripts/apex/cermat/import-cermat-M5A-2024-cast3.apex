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
  'CERMAT M5A 2024 - uloha 7 (konstrukce)',
  new List<String>{'V rovine lezi primka $p$ a mimo ni body $A$ a $S$ (viz obrazek). Bod $A$ je vrchol obdelniku $ABCD$. Bod $S$ je stred strany $AB$ tohoto obdelniku. Na primce $p$ lezi bod $Q$, stred nektere ze sousednich stran strany $AB$ tohoto obdelniku.','7.1 Sestrojte vrchol $B$.','7.2 Na primce $p$ najdete a popiste stred $Q$ dalsi strany obdelniku, sestrojte a popiste vrcholy $C$ a $D$ a obdelnik $ABCD$ narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <line x1="40" y1="250" x2="420" y2="120" stroke="#000" stroke-width="1.5"/> <text x="52" y="272" font-size="16" font-style="italic">p</text> <text x="285" y="150" font-size="15" text-anchor="middle">x</text> <text x="285" y="168" font-size="15" font-style="italic" text-anchor="middle">S</text> <text x="190" y="262" font-size="15" text-anchor="middle">x</text> <text x="190" y="280" font-size="15" font-style="italic" text-anchor="middle">A</text> </svg>',
  'primka-p-body-AS.svg',
  'Primka p a mimo ni body A a S.',
  'Vychozi obrazek k uloze 7',
  new List<String>{'7.1 Bod $S$ je stred strany $AB$, proto $B$ je obrazem bodu $A$ ve stredove soumernosti se stredem $S$: lezi na poloprimce $AS$ tak, ze $|SB|=|SA|$.','7.2 Strany $AD$ a $BC$ jsou kolme k $AB$. Stred $Q$ jedne z nich lezi na primce $p$. Sestrojime kolmici k $AB$ v bode $A$ (resp. v bode $B$); jeji prusecik s primkou $p$ je bod $Q$. Vrchol $D$ (resp. $C$) dopocteme tak, aby $Q$ byl stred strany $AD$ (resp. $BC$), tj. $|AD|=2|AQ|$. Uloha ma dve reseni.'},
  'Dve reseni: $B$ je obraz $A$ ve stredove soumernosti podle $S$; $Q$ je prusecik primky $p$ s kolmici k $AB$ v bode $A$, resp. v bode $B$; obdelnik $ABCD$ se dvema polohami $C$, $D$ - viz obrazek v klici.',
  6, 10, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2024 - uloha 8',
  new List<String>{'Ve ctvercove siti jsou nakresleny dva obrazce $A$ a $B$, jejichz vrcholy lezi v mrizovych bodech. Kazdy ctverecek ctvercove site ma stranu delky $1$ cm a obsah $1$ cm2 (viz obrazek).','Rozhodnete o kazdem z tvrzeni 8.1-8.3, zda je pravdive (A), ci nikoli (N).','8.1 Obsahy obou obrazcu si jsou rovny.','8.2 Obsah obrazce $A$ je $11$ cm2.','8.3 Obvod obrazce $B$ je $16$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 270" font-family="sans-serif"><line x1="20" y1="20" x2="20" y2="244" stroke="#bbb"/><line x1="48" y1="20" x2="48" y2="244" stroke="#bbb"/><line x1="76" y1="20" x2="76" y2="244" stroke="#bbb"/><line x1="104" y1="20" x2="104" y2="244" stroke="#bbb"/><line x1="132" y1="20" x2="132" y2="244" stroke="#bbb"/><line x1="160" y1="20" x2="160" y2="244" stroke="#bbb"/><line x1="188" y1="20" x2="188" y2="244" stroke="#bbb"/><line x1="216" y1="20" x2="216" y2="244" stroke="#bbb"/><line x1="244" y1="20" x2="244" y2="244" stroke="#bbb"/><line x1="272" y1="20" x2="272" y2="244" stroke="#bbb"/><line x1="300" y1="20" x2="300" y2="244" stroke="#bbb"/><line x1="20" y1="20" x2="300" y2="20" stroke="#bbb"/><line x1="20" y1="48" x2="300" y2="48" stroke="#bbb"/><line x1="20" y1="76" x2="300" y2="76" stroke="#bbb"/><line x1="20" y1="104" x2="300" y2="104" stroke="#bbb"/><line x1="20" y1="132" x2="300" y2="132" stroke="#bbb"/><line x1="20" y1="160" x2="300" y2="160" stroke="#bbb"/><line x1="20" y1="188" x2="300" y2="188" stroke="#bbb"/><line x1="20" y1="216" x2="300" y2="216" stroke="#bbb"/><line x1="20" y1="244" x2="300" y2="244" stroke="#bbb"/><polygon points="48,48 104,48 104,76 132,76 132,160 48,160" fill="none" stroke="#000" stroke-width="2.5"/><text x="76" y="70" font-size="16" text-anchor="middle">A</text><polygon points="160,188 188,160 244,188 244,244 160,244" fill="none" stroke="#000" stroke-width="2.5"/><text x="188" y="222" font-size="16" text-anchor="middle">B</text></svg>',
  'obrazce-AB.svg',
  'Ctvercova sit se dvema obrazci A a B, jejich vrcholy lezi v mrizovych bodech.',
  'Obrazce A a B ve ctvercove siti (schematicky nakres)',
  new List<String>{'8.1 Obsah obrazce $A$ je $11$ cm2, obsah obrazce $B$ je jiny, obsahy si tedy nejsou rovny -> Ne.','8.2 Obrazec $A$ pokryva plochu $11$ cm2 -> Ano.','8.3 Obvod obrazce $B$ neni $16$ cm -> Ne.'},
  '8.1: Ne; 8.2: Ano; 8.3: Ne',
  3, 4, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
