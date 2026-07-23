String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD25C0T04';
Integer YEAR = 2025;

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
  'CERMAT M7D 2025 - uloha 8 (konstrukce)',
  new List<String>{'V rovine lezi body $A$, $A^{\\prime}$ a $M$ (viz obrazek). Bod $A$ je vrchol rovnostranneho trojuhelniku $ABC$. Na primce $AM$ lezi vrchol $C$ tohoto trojuhelniku. Bod $A^{\\prime}$ je vrchol trojuhelniku $A^{\\prime}B^{\\prime}C^{\\prime}$, ktery je obrazem trojuhelniku $ABC$ v osove soumernosti s osou $o$. Oba trojuhelniky maji pouze jeden spolecny bod, a to vrchol $C$.','8.1 Sestrojte osu $o$ a oznacte ji pismenem.','8.2 Sestrojte vsechny chybejici vrcholy trojuhelniku $ABC$ i $A^{\\prime}B^{\\prime}C^{\\prime}$, oznacte je pismeny a oba trojuhelniky narysujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif"><rect x="5" y="5" width="490" height="330" fill="none" stroke="#ccc"/><text x="428" y="114" font-size="15">×</text><text x="443" y="118" font-size="15" font-style="italic">M</text><text x="200" y="209" font-size="15">×</text><text x="178" y="213" font-size="15" font-style="italic">A′</text><text x="330" y="304" font-size="15">×</text><text x="316" y="308" font-size="15" font-style="italic">A</text></svg>',
  'body-A-Aprime-M.svg',
  'Tri body oznacene krizky v rovine: M vpravo nahore, A prime vlevo, A dole.',
  'Vychozi obrazek k uloze 8',
  new List<String>{'Osa $o$ je osou usecky $AA^{\\prime}$ (bod $A^{\\prime}$ je obrazem bodu $A$). Vrchol $C$ je jediny spolecny bod obou trojuhelniku, lezi tedy na ose $o$ a zaroven na primce $AM$ - je jejich prusecikem. Trojuhelnik $ABC$ je rovnostranny nad stranou $AC$ (vrchol $B$ dopocteme). Trojuhelnik $A^{\\prime}B^{\\prime}C^{\\prime}$ je obrazem $ABC$ v osove soumernosti podle $o$, pricemz $C^{\\prime}=C$.'},
  'Osa $o$ je osou usecky $AA^{\\prime}$; $C$ je prusecik osy $o$ s primkou $AM$; $ABC$ je rovnostranny nad $AC$ a $A^{\\prime}B^{\\prime}C^{\\prime}$ je jeho obraz v soumernosti podle $o$ (viz obrazek v klici).',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2025 - uloha 9 (konstrukce)',
  new List<String>{'V rovine lezi body $L$, $M$ a primka $p$ prochazejici bodem $M$ (viz obrazek). Body $L$, $M$ jsou vrcholy rovnobezniku $KLMN$. Na primce $p$ lezi stred $S$ soumernosti tohoto rovnobezniku. Delka strany $LM$ je stejna jako delka uhlopricky $LN$.','Sestrojte stred $S$ a vrcholy $K$, $N$ rovnobezniku $KLMN$, oznacte je pismeny a rovnobeznik narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif"><rect x="5" y="5" width="490" height="290" fill="none" stroke="#ccc"/><line x1="60" y1="200" x2="450" y2="120" stroke="#000" stroke-width="1.5"/><line x1="396" y1="123" x2="404" y2="137" stroke="#000" stroke-width="1.5"/><text x="394" y="118" font-size="15" font-style="italic">M</text><text x="456" y="122" font-size="15" font-style="italic">p</text><text x="248" y="234" font-size="15">×</text><text x="250" y="250" font-size="15" font-style="italic">L</text></svg>',
  'body-LM-primka-p.svg',
  'Primka p stoupajici zleva doprava s bodem M na primce a bodem L pod primkou.',
  'Vychozi obrazek k uloze 9',
  new List<String>{'Stred $S$ je stredem uhlopricek, tedy i stredem usecky $LN$, proto $|LN|=2\\cdot|LS|$. Z podminky $|LM|=|LN|$ plyne $|LS|=\\frac{|LM|}{2}$. Bod $S$ je prusecikem primky $p$ s kruznici se stredem $L$ a polomerem $\\frac{|LM|}{2}$ - obecne dve polohy $S$. Pro kazdou z nich je $N$ obrazem $L$ a $K$ obrazem $M$ ve stredove soumernosti podle $S$. Uloha ma dve reseni.'},
  'Dve reseni: $S$ je prusecik primky $p$ s kruznici $(L; \\tfrac{|LM|}{2})$, $N$ a $K$ jsou obrazy $L$ a $M$ ve stredove soumernosti podle $S$ (viz obrazek v klici).',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
