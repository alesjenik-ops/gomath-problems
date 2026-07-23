String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD26C0T02';
Integer YEAR = 2026;

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
  'CERMAT M5B 2026 – úloha 8',
  new List<String>{'Každý žák, který se zúčastnil sportovního dne, si vybral pouze jednu ze čtyř aktivit. Kruhový diagram je rozdělen na 10 stejně velkých dílů a znázorňuje, jaká část žáků si vybrala jednotlivé aktivity. Fotbal si vybralo o 16 žáků více než vybíjenou.','Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Fotbal si vybralo třikrát více žáků než stolní tenis.','8.2 Atletiku si vybralo o třetinu méně žáků než fotbal.','8.3 Sportovního dne se zúčastnilo celkem 80 žáků.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 230" font-family="sans-serif"><defs><pattern id="h8" width="7" height="7" patternUnits="userSpaceOnUse"><rect width="7" height="7" fill="#fff"/><line x1="3.5" y1="0" x2="3.5" y2="7" stroke="#000"/></pattern></defs><path d="M 110 110 L 110.0 18.0 A 92 92 0 0 1 164.1 35.6 Z" fill="#4a4a4a" stroke="#000"/><path d="M 110 110 L 164.1 35.6 A 92 92 0 0 1 197.5 81.6 Z" fill="#4a4a4a" stroke="#000"/><path d="M 110 110 L 197.5 81.6 A 92 92 0 0 1 197.5 138.4 Z" fill="url(#h8)" stroke="#000"/><path d="M 110 110 L 197.5 138.4 A 92 92 0 0 1 164.1 184.4 Z" fill="#cfcfcf" stroke="#000"/><path d="M 110 110 L 164.1 184.4 A 92 92 0 0 1 110.0 202.0 Z" fill="#cfcfcf" stroke="#000"/><path d="M 110 110 L 110.0 202.0 A 92 92 0 0 1 55.9 184.4 Z" fill="#cfcfcf" stroke="#000"/><path d="M 110 110 L 55.9 184.4 A 92 92 0 0 1 22.5 138.4 Z" fill="#ffffff" stroke="#000"/><path d="M 110 110 L 22.5 138.4 A 92 92 0 0 1 22.5 81.6 Z" fill="#ffffff" stroke="#000"/><path d="M 110 110 L 22.5 81.6 A 92 92 0 0 1 55.9 35.6 Z" fill="#ffffff" stroke="#000"/><path d="M 110 110 L 55.9 35.6 A 92 92 0 0 1 110.0 18.0 Z" fill="#ffffff" stroke="#000"/><rect x="225" y="58" width="16" height="16" fill="#4a4a4a" stroke="#000"/><text x="248" y="71" font-size="13">Vybíjená</text><rect x="225" y="84" width="16" height="16" fill="url(#h8)" stroke="#000"/><text x="248" y="97" font-size="13">Stolní tenis</text><rect x="225" y="110" width="16" height="16" fill="#cfcfcf" stroke="#000"/><text x="248" y="123" font-size="13">Atletika</text><rect x="225" y="136" width="16" height="16" fill="#ffffff" stroke="#000"/><text x="248" y="149" font-size="13">Fotbal</text></svg>',
  'diagram-sport.svg',
  'Kruhový diagram o 10 stejných dílech: vybíjená 2 díly, stolní tenis 1 díl, atletika 3 díly, fotbal 4 díly.',
  'Rozdělení žáků podle vybrané aktivity',
  new List<String>{'Z diagramu: vybíjená 2 díly, stolní tenis 1 díl, atletika 3 díly, fotbal 4 díly. Rozdíl fotbal $-$ vybíjená $= 2$ díly $= 16$ žáků, takže 1 díl $= 8$ žáků a celkem $10\\cdot 8 = 80$ žáků.','8.1 Fotbal $32$ žáků, stolní tenis $8$ žáků; $3\\cdot 8 = 24 \\ne 32$ → Ne.','8.2 Fotbal $32$; o třetinu méně je $32 - \\frac{32}{3} \\doteq 21{,}3$; atletika je $24$ → Ne.','8.3 $10$ dílů po $8$ žácích $= 80$ žáků → Ano.'},
  '8.1: N; 8.2: N; 8.3: A',
  4, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2026 – úloha 9',
  new List<String>{'Katka má stejný počet korunových, dvoukorunových, pětikorunových i desetikorunových mincí. Jiné peníze nemá. Celkem má 252 korun.','Kolik mincí má Katka?'},
  new List<String>{'A) 18 mincí','B) 32 mincí','C) 48 mincí','D) 56 mincí','E) jiný počet mincí'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označíme $n$ počet mincí každého druhu. Hodnota $n\\cdot(1+2+5+10) = 18n = 252$, tedy $n = 14$. Celkem $4\\cdot 14 = 56$ mincí.'},
  'D) 56 mincí',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
