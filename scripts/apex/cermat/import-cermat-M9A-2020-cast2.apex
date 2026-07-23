String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD20C0T01';
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
  'CERMAT M9A 2020 – úloha 6',
  new List<String>{'Tři vázy mají různé velikosti. Objem velké vázy je o polovinu větší než objem střední vázy. Objem střední vázy je čtyřikrát větší než objem malé vázy. Neznámý objem střední vázy označte $x$.','6.1 V závislosti na veličině $x$ vyjádřete objem velké vázy.','6.2 V závislosti na veličině $x$ vyjádřete objem malé vázy.','6.3 Všechny tři vázy dohromady mají objem $5{,}5$ litru. Vypočtěte v litrech objem střední vázy.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Velká váza je o polovinu větší než střední: $x + \\frac{x}{2} = \\frac{3x}{2}$.','6.2 Střední váza je čtyřikrát větší než malá, tedy malá má objem $\\frac{x}{4}$.','6.3 $\\frac{3x}{2} + x + \\frac{x}{4} = 5{,}5$; $\\frac{6x+4x+x}{4} = \\frac{11x}{4} = 5{,}5$; $11x = 22$; $x = 2$ litry.'},
  '6.1: $\\frac{3x}{2}$; 6.2: $\\frac{x}{4}$; 6.3: $2$ litry',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2020 – úloha 7',
  new List<String>{'Škrabací sloupek pro kočky má tvar rotačního válce. Válec má výšku $50$ cm a jeho podstava má průměr $14$ cm. Obě podstavy jsou bílé, plášť válce je šedý. (Za $\\pi$ dosazujte $\\frac{22}{7}$.)','7.1 Vypočtěte v cm² obsah jedné podstavy válce.','7.2 Vypočtěte v cm² obsah pláště válce.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 250 320" font-family="sans-serif"> <path d="M55 65 L55 255 A65 20 0 0 0 185 255 L185 65" fill="#cccccc" stroke="#000" stroke-width="2"/> <ellipse cx="120" cy="65" rx="65" ry="20" fill="#ffffff" stroke="#000" stroke-width="2"/> <line x1="55" y1="65" x2="185" y2="65" stroke="#000" stroke-width="0.8" stroke-dasharray="3 3"/> <line x1="70" y1="34" x2="170" y2="34" stroke="#000" stroke-width="1"/> <polygon points="70,34 78,30 78,38" fill="#000"/><polygon points="170,34 162,30 162,38" fill="#000"/> <text x="120" y="26" font-size="15" text-anchor="middle">14 cm</text> <line x1="210" y1="65" x2="210" y2="270" stroke="#000" stroke-width="1"/> <polygon points="210,65 206,74 214,74" fill="#000"/><polygon points="210,270 206,261 214,261" fill="#000"/> <text x="218" y="172" font-size="15">50 cm</text> </svg>',
  'valec.svg',
  'Rotační válec o výšce 50 cm a průměru podstavy 14 cm; podstavy bílé, plášť šedý.',
  'Škrabací sloupek ve tvaru válce',
  new List<String>{'7.1 Poloměr $r = 7$ cm. Obsah podstavy $S = \\pi r^2 = \\frac{22}{7}\\cdot 7^2 = 22\\cdot 7 = 154$ cm².','7.2 Plášť $S_{pl} = \\pi d \\cdot v = \\frac{22}{7}\\cdot 14 \\cdot 50 = 22\\cdot 2\\cdot 50 = 2\\,200$ cm².'},
  '7.1: $154$ cm²; 7.2: $2\\,200$ cm²',
  3, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
