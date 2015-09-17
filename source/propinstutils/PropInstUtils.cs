using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;
using cba.Util;
using Microsoft.Boogie;

namespace PropInstUtils
{
    public class PropInstUtils
    {
        public static bool AreAttributesASubset(QKeyValue left, QKeyValue right)
        {
            for (; left != null; left = left.Next) //TODO: make a reference copy of left to work on??
            {
                //need to filter out keyword attributes
                if (BoogieKeyWords.AllKeywords.Contains(left.Key))
                {
                    continue;
                }

                if (!BoogieUtil.checkAttrExists(left.Key, right))
                {
                    return false;
                }
            }
            return true;
        }
    }


}
